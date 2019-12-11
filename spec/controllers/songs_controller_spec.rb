require 'rails_helper'

RSpec.describe SongsController, type: :controller do
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

    describe 'GET #show' do
      let!(:song) { Fabricate :song, group: group }

      before { get :show, params: { group_id: group, id: song } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'GET #new' do
      before { get :new, params: { group_id: group } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'GET #edit' do
      let!(:song) { Fabricate :song, group: group }

      before { get :edit, params: { group_id: group, id: song } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'POST #create' do
      let!(:song) { { title: 'foo', author: 'bar', tone: 'C' } }

      before { post :create, params: { group_id: group, song: song } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'PUT #update' do
      let!(:song) { Fabricate :song, group: group }
      let!(:valid_data) { { title: 'foo', author: 'bar', tone: 'C' } }

      before { put :update, params: { group_id: group, id: song, song: valid_data } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'DELETE #destroy' do
      let!(:song) { Fabricate :song, group: group }

      before { delete :destroy, params: { group_id: group, id: song } }

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
        let!(:songs) { Fabricate.times 10, :song, group: group }

        before { get :index, params: { group_id: group } }

        it 'lists all group songs' do
          expect(response).to render_template :index
          expect(assigns(:songs)).to match_array songs
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:songs) { Fabricate.times 2, :song, group: group }

        before { get :index, params: { group_id: group } }

        it 'does not list group songs' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET #show' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:song) { Fabricate :song, group: group }

        before { get :show, params: { group_id: group, id: song } }

        it 'shows the song page' do
          expect(response).to render_template :show
          expect(assigns(:song)).to eq song
        end
      end
      
      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:song) { Fabricate :song, group: group }

        before { get :show, params: { group_id: group, id: song } }

        it 'does not show the song page' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET #new' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        before { get :new, params: { group_id: group } }

        it 'shows the songs form' do
          expect(response).to render_template :new
          expect(assigns(:song)).to be_a_new Song
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }

        before { get :new, params: { group_id: group } }

        it 'does not show the songs form' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET #edit' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:song) { Fabricate :song, group: group }

        before { get :edit, params: { group_id: group, id: song } }

        it 'shows the songs form' do
          expect(response).to render_template :edit
          expect(assigns(:song)).to eq song
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:song) { Fabricate :song, group: group }

        before { get :edit, params: { group_id: group, id: song } }

        it 'does not show the songs form' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end

    end

    describe 'POST #create' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        context 'with valid data' do
          let!(:song) { { title: 'foo', author: 'bar', tone: 'C' } }

          before { post :create, params: { group_id: group, song: song } }

          it 'creates a song' do
            expect(response).to redirect_to group_songs_path(group)
            expect(group.songs.count).to eq 1
          end
        end

        context 'with invalid data' do
          let!(:invalid_data) { { title: '', tone: 'H' } }

          before { post :create, params: { group_id: group, song: invalid_data } }

          it 'does not create a song' do
            expect(response).to render_template :new
            expect(group.songs.count).to eq 0
          end
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:song) { { title: 'foo', author: 'bar', tone: 'C' } }

        before { post :create, params: { group_id: group, song: song } }

        it 'does not create a song' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'PUT #update' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        context 'with valid data' do
          let!(:song) { Fabricate :song, group: group }
          let!(:valid_data) { { title: 'foo', author: 'bar', tone: 'C' } }

          before { put :update, params: { group_id: group, id: song, song: valid_data } }

          it 'updates the song' do
            expect(response).to redirect_to group_songs_path(group)
            expect(song.reload.title).to eq 'foo'
          end
        end

        context 'with invalid data' do
          let!(:song) { Fabricate :song, group: group }
          let!(:invalid_data) { { title: '', tone: 'H' } }

          before { put :update, params: { group_id: group, id: song, song: invalid_data } }

          it 'does not update the song' do
            expect(response).to render_template :edit
            expect(song.reload.title).to_not eq ''
          end
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:song) { Fabricate :song, group: group }
        let!(:valid_data) { { title: 'foo', author: 'bar', tone: 'C' } }

        before { put :update, params: { group_id: group, id: song, song: valid_data } }

        it 'does not update the song' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:song) { Fabricate :song, group: group }

        before { delete :destroy, params: { group_id: group, id: song } }

        it 'deletes the song' do
          expect(response).to redirect_to group_songs_path(group)
          expect(group.songs.count).to eq 0
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:song) { Fabricate :song, group: group }

        before { delete :destroy, params: { group_id: group, id: song } }

        it 'does not delete the song' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET #authors' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:song1) { Fabricate :song, group: group, author: 'foo' }
        let!(:song2) { Fabricate :song, group: group, author: 'bar' }
        let!(:song3) { Fabricate :song, author: 'baz' }

        before { get :authors, params: { group_id: group, format: :json } }

        it 'get all the songs authors' do
          expect(response).to have_http_status :ok
          expect(assigns(:authors)).to match_array ['foo', 'bar']
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:song) { Fabricate :song, group: group, author: 'foo' }

        before { get :authors, params: { group_id: group, format: :json } }

        it 'does not get the songs authors' do
          expect(response).to have_http_status :bad_request
        end
      end
    end
  end
end
