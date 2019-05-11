require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  context 'unauthenticated user' do
    describe 'GET #index' do
      before { get :index }

      it 'redirects the user to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: 1 } }

      it 'redirects the user to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'GET #new' do
      before { get :new }

      it 'redirects the user to login page' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  context 'authenticated user' do
    let!(:user) { Fabricate :user }

    before { sign_in user }

    describe 'GET #index' do
      let!(:user_groups) { Fabricate :group, member: user }
      let!(:other_groups) { Fabricate.times 2, :group }

      before { get :index }

      it 'lists all groups' do
        expect(response.status).to render_template :index
        expect(assigns(:user_groups)).to match_array [ user_groups ]
        expect(assigns(:other_groups)).to match_array other_groups
      end
    end

    describe 'GET #show' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        before { get :show, params: { id: group } }

        it 'shows the group page' do
          expect(response).to render_template :show
          expect(assigns(:group)).to eq group
          expect(user.reload.last_group).to eq group
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }

        before { get :show, params: { id: group } }

        it 'show the group page but does not set last group' do
          expect(response).to render_template :show
          expect(assigns(:group)).to eq group
          expect(user.reload.last_group).to eq nil
        end
      end
    end

    describe 'GET #new' do
      before { get :new }

      it 'shows the groups form' do
        expect(response).to render_template :new
        expect(assigns(:group)).to be_a_new Group
      end
    end

    describe 'GET #edit' do
      context 'when the user is the admin' do
        let!(:group) { Fabricate :group, admin: user }

        before { get :edit, params: { id: group } }

        it 'shows the groups form' do
          expect(response).to render_template :edit
          expect(assigns(:group)).to eq group
        end
      end

      context 'when the user is not the admin' do
        let!(:group) { Fabricate :group, member: user }

        before { get :edit, params: { id: group } }

        it 'does not show the groups form' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'POST #create' do
      context 'with invalid data' do
        let(:group) { { name: ''} }

        before { post :create, params: { group: group } }

        it 'does not create a group' do
          expect(response).to render_template :new
          expect(user.groups.count).to eq 0
        end
      end

      context 'with valid data' do
        let(:group) { { name: 'foo'} }

        before { post :create, params: { group: group } }

        it 'creates a group' do
          expect(response).to redirect_to group_path(assigns(:group))
          expect(user.reload.last_group).to eq assigns(:group)
          expect(assigns(:group).members).to_not be_empty
          expect(assigns(:group).members.first.user).to eq user
          expect(assigns(:group).members.first.admin).to eq true
        end
      end
    end

    describe 'PUT #update' do
      context 'when the user is the admin' do
        let!(:group) { Fabricate :group, admin: user }

        context 'with invalid data' do
          let(:invalid_data) { { name: ''} }

          before { put :update, params: { id: group, group: invalid_data } }

          it 'does not update the group' do
            expect(response).to render_template :edit
            expect(group.reload.name).to_not eq ''
          end
        end

        context 'with valid data' do
          let(:valid_data) { { name: 'foo'} }

          before { put :update, params: { id: group, group: valid_data } }

          it 'updates the group' do
            expect(response).to redirect_to group_path(group)
            expect(group.reload.name).to eq 'foo'
          end
        end
      end

      context 'when the user is not the admin' do
        let!(:group) { Fabricate :group, member: user }
        let(:valid_data) { { name: 'foo'} }

        before { put :update, params: { id: group, group: valid_data } }

        it 'does not update the group' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET #candidates' do
      let!(:users) { Fabricate.times 3, :user }

      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        before do
          allow_any_instance_of(AvatarUploader).to receive(:default_url).and_return('avatar.png')
          get :candidates, params: { id: group, format: :json }
        end

        it 'lists all candidates' do
          expect(response).to have_http_status :ok
          expect(assigns(:candidates)).to match_array users
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }

        before { get :candidates, params: { id: group, format: :json } }

        it 'does not list the candidates' do
          expect(response).to have_http_status :bad_request
        end
      end
    end
  end
end
