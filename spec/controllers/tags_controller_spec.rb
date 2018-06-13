require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  context 'with unauthenticated user' do
    let!(:user) { Fabricate :user }
    let!(:group) { Fabricate :group, admin: user }

    describe 'GET #index' do
      context 'through web browser' do
        before { get :index, params: { group_id: group } }

        it 'redirects to login page' do
          expect(response).to redirect_to user_session_path
        end
      end

      context 'through javascript' do
        before { get :index, params: { group_id: group, format: :json } }

        it 'returns unauthorized status' do
          expect(response).to have_http_status :unauthorized
        end
      end
    end

    describe 'GET #edit' do
      let!(:tag) { Fabricate :tag, group: group }

      before { get :edit, params: { group_id: group, id: tag } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'POST #create' do
      let!(:color) { Fabricate :color }
      let(:tag) { { name: 'foo', color_id: color } }

      before { post :create, params: { group_id: group, tag: tag } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'PUT #update' do
      let!(:color) { Fabricate :color }
      let!(:tag) { Fabricate :tag, color: color, group: group  }
      let(:valid_data) { { name: 'foo', color_id: color } }

      before { put :update, params: { group_id: group, id: tag, tag: valid_data } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'DELETE #destroy' do
      let!(:color) { Fabricate :color }
      let!(:tag) { Fabricate :tag, color: color, group: group  }

      before { delete :destroy, params: { group_id: group, id: tag } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  context 'with authenticated user' do
    let!(:user) { Fabricate :user }

    before { sign_in user }

    describe 'GET #index' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        context 'through web browser' do
          let!(:tags) { Fabricate.times 2, :tag, group: group }

          before { get :index, params: { group_id: group } }

          it 'lists all group tags' do
            expect(response).to render_template :index
            expect(assigns(:tag)).to be_a_new Tag
            expect(assigns(:tags)).to eq group.tags
          end
        end

        context 'through javascript' do
          let!(:tags) { Fabricate.times 2, :tag, group: group }

          before { get :index, params: { group_id: group, format: :json } }

          it 'lists all group tags' do
            expect(response).to have_http_status :ok
            expect(assigns(:tags)).to match_array tags
          end
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }

        context 'through web browser' do
          let!(:tags) { Fabricate.times 2, :tag, group: group }

          before { get :index, params: { group_id: group } }

          it 'does not list group tags' do
            expect(response).to redirect_to root_path
            expect(flash[:alert]).to be_present
          end
        end

        context 'through javascript' do
          let!(:tags) { Fabricate.times 2, :tag, group: group }

          before { get :index, params: { group_id: group, format: :json } }

          it 'does not list group tags' do
            expect(response).to have_http_status :bad_request
          end
        end
      end
    end

    describe 'GET #edit' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:tag) { Fabricate :tag, group: group }

        before { get :edit, params: { group_id: group, id: tag } }

        it 'shows the tag form' do
          expect(response).to render_template :edit
          expect(assigns(:tag)).to eq tag
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:tag) { Fabricate :tag, group: group }

        before { get :edit, params: { group_id: group, id: tag } }

        it 'does not show the tag form' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'POST #create' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:color) { Fabricate :color }

        context 'with valid data' do
          let(:tag) { { name: 'foo', color_id: color } }

          before { post :create, params: { group_id: group, tag: tag } }

          it 'creates a tag' do
            expect(response).to redirect_to group_tags_path(group)
            expect(group.tags.count).to eq 1
          end
        end

        context 'with invalid tag' do
          let(:tag) { { name: '', color_id: '' } }

          before { post :create, params: { group_id: group, tag: tag } }

          it 'does not create a tag' do
            expect(response).to render_template :index
            expect(group.tags.count).to eq 0
          end
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:color) { Fabricate :color }
        let(:tag) { { name: 'foo', color_id: color } }

        before { post :create, params: { group_id: group, tag: tag } }

        it 'does not create a tag' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'PUT #update' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        context 'with valid data' do
          let!(:tag) { Fabricate :tag, group: group  }
          let!(:color) { Fabricate :color, name: 'red' }
          let(:valid_data) { { name: 'foo', color_id: color } }

          before { put :update, params: { group_id: group, id: tag, tag: valid_data } }

          it 'updates the tag' do
            expect(response).to redirect_to group_tags_path(group)
            expect(tag.reload.name).to eq 'foo'
            expect(tag.color).to eq color
          end
        end

        context 'with invalid tag' do
          let!(:tag) { Fabricate :tag, group: group }
          let!(:invalid_data) { { name: '', color_id: nil } }

          before { put :update, params: { group_id: group, id: tag, tag: invalid_data } }

          it 'does not update the tag' do
            expect(response).to render_template :edit
            expect(tag.reload.name).to_not eq ''
          end
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:tag) { Fabricate :tag, group: group }
        let(:valid_data) { { name: 'foo' } }

        before { put :update, params: { group_id: group, id: tag, tag: valid_data } }

        it 'does not update the tag' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:tag) { Fabricate :tag, group: group }

        before { delete :destroy, params: { group_id: group, id: tag } }

        it 'deletes the tag' do
          expect(response).to redirect_to group_tags_path
          expect(group.tags.count).to eq 0
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:tag) { Fabricate :tag, group: group }

        before { delete :destroy, params: { group_id: group, id: tag } }

        it 'does not delete the tag' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end
  end
end
