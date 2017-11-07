require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  context 'authenticated user' do
    let!(:user) { Fabricate :user }
    let!(:member) { Fabricate.build :member_admin, user: user }
    let!(:group) { Fabricate :group, members: [member]  }
    let!(:song) { Fabricate :song, group: group }

    before { sign_in user }
    before { assign_group(user, group) }

    describe 'GET #edit' do
      let!(:comment) { Fabricate :comment, target: song, commenter: user }

      before { get :edit, params: { song_id: song.id, id: comment.id } }

      it { expect(response).to render_template :edit }
      it { expect(assigns(:comment)).to eq comment }
    end

    describe 'POST #create' do
      context 'valid comment' do
        let!(:comment) { { body: 'foo' } }

        before { post :create, params: { song_id: song.id, comment: comment } }

        it { expect(response).to redirect_to group_song_path(group, song) }
        it { expect(song.comments.count).to eq 1 }
        it { expect(user.comments.count).to eq 1 }
      end

      context 'invalid comment' do
        let!(:comment) { { body: '' } }

        before { post :create, params: { song_id: song.id, comment: comment } }

        it { expect(response).to have_http_status :bad_request }
        it { expect(response).to render_template :edit }
        it { expect(song.comments.count).to eq 0 }
      end
    end

    describe 'PUT #update' do
      context 'valid comment' do
        let!(:comment) { Fabricate :comment, target: song, commenter: user }
        let!(:valid_comment) { { body: 'foo' } }

        before { put :update, params: { song_id: song.id, id: comment.id, comment: valid_comment } }

        it { expect(response).to redirect_to group_song_path(group, song) }
        it { expect(comment.reload.body).to eq 'foo' }
      end

      context 'invalid comment' do
        let!(:comment) { Fabricate :comment, target: song, commenter: user }
        let!(:valid_comment) { { body: '' } }

        before { put :update, params: { song_id: song.id, id: comment.id, comment: valid_comment } }

        it { expect(response).to have_http_status :bad_request }
        it { expect(response).to render_template :edit }
      end
    end

    describe 'DELETE #destroy' do
      let!(:comment) { Fabricate :comment, target: song, commenter: user }

      before { delete :destroy, params: { song_id: song.id, id: comment.id } }

      it { expect(response).to redirect_to group_song_path(group, song) }
      it { expect(song.comments.count).to eq 0 }
    end
  end
end
