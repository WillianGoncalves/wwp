require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  context 'with unauthenticated user' do
    describe 'POST #create' do
      let!(:song) { Fabricate :song }
      let!(:comment) { { body: 'foo' } }

      before { post :create, params: { song_id: song, comment: comment } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'PUT #update' do
      let!(:comment) { Fabricate :song_comment }
      let!(:valid_comment) { { body: 'foo' } }

      before { put :update, params: { id: comment, comment: valid_comment, format: :json } }

      it 'redirects to login page' do
        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'DELETE #destroy' do
      let!(:comment) { Fabricate :song_comment }

      before { delete :destroy, params: { song_id: comment.target, id: comment } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  context 'with authenticated user' do
    let!(:user) { Fabricate :user }

    before { sign_in user }

    describe 'POST #create' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        context 'commenting a song' do
          let!(:song) { Fabricate :song, group: group }

          context 'with valid data' do
            let!(:comment) { { body: 'foo' } }

            before { post :create, params: { song_id: song, comment: comment } }

            it 'creates a comment' do
              expect(response).to redirect_to group_song_path(group, song)
              expect(song.comments.count).to eq 1
              expect(user.comments.count).to eq 1
            end
          end

          context 'with invalid data' do
            let!(:comment) { { body: '' } }

            before { post :create, params: { song_id: song, comment: comment } }

            it 'does not create a comment' do
              expect(response).to redirect_to group_song_path(group, song)
              expect(flash[:error]).to be_present
              expect(song.comments.count).to eq 0
            end
          end
        end

        context 'commenting a presentation' do
          let!(:presentation) { Fabricate :presentation, group: group }

          context 'with valid data' do
            let!(:comment) { { body: 'foo' } }

            before { post :create, params: { presentation_id: presentation, comment: comment } }

            it 'creates a comment' do
              expect(response).to redirect_to group_presentation_path(group, presentation)
              expect(presentation.comments.count).to eq 1
              expect(user.comments.count).to eq 1
            end
          end

          context 'with invalid data' do
            let!(:comment) { { body: '' } }

            before { post :create, params: { presentation_id: presentation, comment: comment } }

            it 'does not create a comment' do
              expect(response).to redirect_to group_presentation_path(group, presentation)
              expect(flash[:error]).to be_present
              expect(presentation.comments.count).to eq 0
            end
          end
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:song) { Fabricate :song }
        let!(:comment) { { body: 'foo' } }

        before { post :create, params: { song_id: song, comment: comment } }

        it 'creates a comment' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
          expect(song.comments.count).to eq 0
          expect(user.comments.count).to eq 0
        end
      end
    end

    describe 'PUT #update' do
      context 'when the user is the commenter' do
        let!(:group) { Fabricate :group, member: user }

        context 'editing a song comment' do
          let!(:song) { Fabricate :song, group: group }
          let!(:comment) { Fabricate :song_comment, target: song, commenter: user }

          context 'with valid data' do
            let!(:valid_data) { { body: 'foo' } }

            before { put :update, params: { id: comment, comment: valid_data, format: :json } }

            it 'updates the comment' do
              expect(response).to have_http_status :ok
              expect(comment.reload.body).to eq 'foo'
            end
          end

          context 'with invalid data' do
            let!(:invalid_data) { { body: '' } }

            before { put :update, params: { id: comment, comment: invalid_data, format: :json } }

            it 'does not update the comment' do
              expect(response).to have_http_status :bad_request
              expect(comment.reload.body).not_to eq ''
            end
          end
        end

        context 'editing a presentation comment' do
          let!(:presentation) { Fabricate :presentation, group: group }
          let!(:comment) { Fabricate :presentation_comment, target: presentation, commenter: user }

          context 'with valid data' do
            let!(:valid_data) { { body: 'foo' } }

            before { put :update, params: { id: comment, comment: valid_data, format: :json } }

            it 'updates the comment' do
              expect(response).to have_http_status :ok
              expect(comment.reload.body).to eq 'foo'
            end
          end

          context 'with invalid data' do
            let!(:invalid_data) { { body: '' } }

            before { put :update, params: { id: comment, comment: invalid_data, format: :json } }

            it 'does not update the comment' do
              expect(response).to have_http_status :bad_request
              expect(comment.reload.body).not_to eq ''
            end
          end
        end
      end

      context 'when the user is not the commenter' do
        let!(:comment) { Fabricate :song_comment }
        let!(:valid_data) { { body: 'foo' } }

        before { put :update, params: { song_id: comment.target, id: comment, comment: valid_data } }

        it 'does not update the comment' do
          expect(response).to redirect_to root_path
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'when the user is the commenter' do
        let!(:group) { Fabricate :group, member: user }

        context 'deleting a song comment' do
          let!(:song) { Fabricate :song, group: group }
          let!(:comment) { Fabricate :song_comment, target: song, commenter: user }

          before { delete :destroy, params: { song_id: song, id: comment } }

          it 'deletes a comment' do
            expect(response).to redirect_to group_song_path(group, song)
            expect(song.comments.count).to eq 0
          end
        end

        context 'deleting a presentation comment' do
          let!(:presentation) { Fabricate :presentation, group: group }
          let!(:comment) { Fabricate :presentation_comment, target: presentation, commenter: user }

          before { delete :destroy, params: { presentation_id: presentation, id: comment } }

          it 'deletes a comment' do
            expect(response).to redirect_to group_presentation_path(group, presentation)
            expect(presentation.comments.count).to eq 0
          end
        end
      end

      context 'when the user is not the commenter' do
        let!(:comment) { Fabricate :song_comment }

        before { delete :destroy, params: { song_id: comment.target, id: comment } }

        it 'does not delete the comment' do
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
