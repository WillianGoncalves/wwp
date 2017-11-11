require 'rails_helper'

RSpec.describe SongsController, type: :controller do

  context 'authenticated user' do

    let!(:user) { Fabricate :user }
    let!(:member) { Fabricate.build :member_admin, user: user }
    let!(:group) { Fabricate :group, members: [member]  }

    before { sign_in user }
    before { assign_group(user, group) }

    describe 'GET #index' do
      let!(:song1) { Fabricate :song, group: group }
      let!(:song2) { Fabricate :song, group: group }

      before { get :index, params: { group_id: group.id } }

      it { expect(response).to render_template :index }
      it { expect(assigns(:songs)).to eq group.songs }
    end

    describe 'GET #show' do
      let!(:song) { Fabricate :song, group: group }

      before { get :show, params: { group_id: group.id, id: song.id } }

      it { expect(response).to render_template :show }
      it { expect(assigns(:song)).to eq song }
    end

    describe 'GET #new' do
      before { get :new, params: { group_id: group.id } }

      it { expect(response).to render_template :new }
      it { expect(assigns(:song)).to be_a_new Song }
    end

    describe 'GET #edit' do
      let!(:song) { Fabricate :song, group: group }

      before { get :edit, params: { group_id: group.id, id: song.id } }

      it { expect(response).to render_template :edit }
      it { expect(assigns(:song)).to eq song }
    end

    describe 'POST #create' do
      context 'valid song' do
        let!(:song) { { title: 'foo', author: 'bar', tone: 'C' } }

        before { post :create, params: { group_id: group.id, song: song } }

        it { expect(response).to redirect_to group_songs_path(group) }
        it { expect(group.songs.count).to eq 1 }
      end

      context 'invalid song' do
        let!(:invalid_song) { { title: '', tone: 'H' } }

        before { post :create, params: { group_id: group.id, song: invalid_song } }

        it { expect(response).to have_http_status :bad_request }
        it { expect(response).to render_template :new }
        it { expect(group.songs.count).to eq 0 }
      end
    end

    describe 'PUT #update' do
      context 'valid sont' do
        let!(:song) { Fabricate :song, group: group }
        let!(:valid_song) { { title: 'foo', author: 'bar', tone: 'C' } }

        before { put :update, params: { group_id: group.id, id: song.id, song: valid_song } }

        it { expect(response).to redirect_to group_songs_path(group) }
        it { expect(song.reload.title).to eq 'foo' }
      end

      context 'invalid song' do
        let!(:song) { Fabricate :song, group: group }
        let!(:invalid_song) { { title: '', tone: 'H' } }

        before { put :update, params: { group_id: group.id, id: song.id, song: invalid_song } }

        it { expect(response).to have_http_status :bad_request }
        it { expect(response).to render_template :edit }
      end
    end

    describe 'DELETE #destroy' do
      let!(:song) { Fabricate :song, group: group }

      before { delete :destroy, params: { group_id: group.id, id: song.id } }

      it { expect(response).to redirect_to group_songs_path(group) }
      it { expect(group.songs.count).to eq 0 }
      it { expect(group.songs.with_deleted.count).to eq 1 }
    end
  end
end
