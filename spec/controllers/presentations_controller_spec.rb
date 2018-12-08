require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do
  context 'with unathenticated user' do
    let!(:user) { Fabricate :user }
    let!(:group) { Fabricate :group, admin: user }

    describe 'GET #index' do
      before { get :index, params: { group_id: group } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'GET #show' do
      let!(:presentation) { Fabricate :presentation, group: group }

      before { get :show, params: { group_id: group, id: presentation } }

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
      let!(:presentation) { Fabricate :presentation, group: group }

      before { get :edit, params: { group_id: group, id: presentation } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'POST #create' do
      let!(:presentation) { { local: 'foo' } }

      before { post :create, params: { group_id: group, presentation: presentation } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'PUT #update' do
      let!(:presentation) { Fabricate :presentation, group: group }
      let!(:valid_data) { { local: 'foo' } }

      before { put :update, params: { group_id: group, id: presentation, song: valid_data } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'DELETE #destroy' do
      let!(:presentation) { Fabricate :presentation, group: group }

      before { delete :destroy, params: { group_id: group, id: presentation } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  context 'authenticated user' do
    let!(:user) { Fabricate :user }

    before { sign_in user }

    describe 'GET #index' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:presentation1) { Fabricate :presentation, group: group, date_time: 1.minute.from_now }
        let!(:presentation2) { Fabricate :presentation, group: group, date_time: DateTime.now.next_month }

        context 'without date params' do
          before { get :index, params: { group_id: group } }

          it 'lists all presentations in the current month' do
            expect(response).to render_template :index
            expect(assigns(:presentations)).to match_array [ presentation1 ]
            expect(assigns(:month)).to eq DateTime.now.month
            expect(assigns(:year)).to eq DateTime.now.year
          end
        end

        context 'with date params' do
          let(:date) { Date.today.next_month }

          before { get :index, params: { group_id: group, month: date.month, year: date.year } }

          it 'lists all presentations matching the date' do
            expect(response).to render_template :index
            expect(assigns(:presentations)).to match_array [ presentation2 ]
          end
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }

        before { get :index, params: { group_id: group } }

        it 'does not list group presentations' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET #show' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:presentation) { Fabricate :presentation, group: group }

        before { get :show, params: { group_id: group, id: presentation } }

        it 'shows the presentation page' do
          expect(response).to render_template :show
          expect(assigns(:presentation)).to eq presentation
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:presentation) { Fabricate :presentation, group: group }

        before { get :show, params: { group_id: group, id: presentation } }

        it 'does not show the presentation page' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET #new' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        before { get :new, params: { group_id: group } }

        it 'shows the presentations form' do
          expect(response).to render_template :new
          expect(assigns(:presentation)).to be_a_new Presentation
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }

        before { get :new, params: { group_id: group } }

        it 'does not show the presentations form' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET #edit' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:presentation) { Fabricate :presentation, group: group }

        before { get :edit, params: { group_id: group, id: presentation } }

        it 'shows the presentations form' do
          expect(response).to render_template :edit
          expect(assigns(:presentation)).to eq presentation
          expect(assigns(:date)).to eq presentation.date_time.strftime("%d/%m/%Y")
          expect(assigns(:time)).to eq presentation.date_time.strftime("%H:%M")
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:presentation) { Fabricate :presentation, group: group }

        before { get :edit, params: { group_id: group, id: presentation } }

        it 'does not show the presentations form' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'POST #create' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        context 'with valid data' do
          let!(:songs) { Fabricate.times 2, :song, group: group }
          let(:presentation) { { local: 'foo' } }
          let(:date) { Date.today.next_month.strftime("%d/%m/%Y") }

          before { post :create, params: { group_id: group, presentation: presentation, date: date, time: '12:00', song_ids: song_ids(songs) } }

          it 'creates a presentation' do
            expect(response).to redirect_to group_presentations_path(group)
            expect(group.presentations.count).to eq 1
            expect(assigns(:presentation).date_time).to eq "#{ date } 12:00"
            expect(assigns(:presentation).songs).to match_array songs
          end
        end

        context 'with invalid data' do
          context 'blank data' do
            let(:presentation) { { local: '' } }

            before { post :create, params: { group_id: group, presentation: presentation, date: '', time: '', song_ids: '' } }

            it 'does not create a presentation' do
              expect(response).to render_template :new
              expect(group.presentations.count).to eq 0
            end
          end

          context 'invalid date' do
            let!(:songs) { Fabricate.times 2, :song, group: group }
            let(:presentation) { { local: 'foo' } }

            before { post :create, params: { group_id: group, presentation: presentation, date: '01/01/2000', time: '12:00', song_ids: song_ids(songs) } }

            it 'does not create a presentation' do
              expect(response).to render_template :new
              expect(group.presentations.count).to eq 0
            end
          end
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:songs) { Fabricate.times 2, :song, group: group }
        let(:presentation) { { local: 'foo' } }
        let(:date) { Date.today.next_month.strftime("%d/%m/%Y") }

        before { post :create, params: { group_id: group, presentation: presentation, date: date, time: '12:00', song_ids: song_ids(songs) } }

        it 'does not create a presentation' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'PUT #update' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }

        context 'with valid data' do
          let!(:presentation) { Fabricate :presentation, group: group }
          let!(:songs) { Fabricate.times 2, :song, group: group }
          let(:valid_data) { { local: 'foo' } }
          let(:date) { Date.today.next_month.strftime("%d/%m/%Y") }

          before { put :update, params: { group_id: group, id: presentation, presentation: valid_data, date: date, time: '12:00', song_ids: song_ids(songs) } }

          it 'updates the presentation' do
            expect(response).to redirect_to group_presentations_path(group)
            expect(presentation.reload.local).to eq 'foo'
            expect(assigns(:presentation).date_time).to eq "#{ date } 12:00"
            expect(presentation.songs).to match_array songs
          end
        end

        context 'with invalid data' do
          let!(:presentation) { Fabricate :presentation, group: group }
          let!(:invalid_data) { { local: '' } }

          before { put :update, params: { group_id: group, id: presentation, presentation: invalid_data, date: '', time: '', song_ids: '' } }

          it 'does not update the presentation' do
            expect(response).to render_template :edit
            expect(presentation.reload.date_time).not_to eq ''
            expect(presentation.local).not_to eq 'foo'
          end
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:presentation) { Fabricate :presentation, group: group }
        let!(:songs) { Fabricate.times 2, :song, group: group }
        let(:valid_data) { { local: 'foo' } }
        let(:date) { Date.today.next_month.strftime("%d/%m/%Y") }

        before { put :update, params: { group_id: group, id: presentation, presentation: valid_data, date: date, time: '12:00', song_ids: song_ids(songs) } }

        it 'does not update the presentations' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:presentation) { Fabricate :presentation, group: group }

        before { delete :destroy, params: { group_id: group, id: presentation } }

        it 'deletes the presentation' do
          expect(response).to redirect_to group_presentations_path(group)
          expect(group.presentations.count).to eq 0
          expect(group.presentations.with_deleted.count).to eq 1
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:presentation) { Fabricate :presentation, group: group }

        before { delete :destroy, params: { group_id: group, id: presentation } }

        it 'does not delete the presentation' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'GET #play' do
      context 'when the user is a member' do
        let!(:group) { Fabricate :group, member: user }
        let!(:presentation) { Fabricate :presentation, group: group }

        before { get :play, params: { id: presentation } }

        it 'shows the play page' do
          expect(response).to render_template :play, layout: :blank
          expect(assigns(:presentation)).to eq presentation
        end
      end

      context 'when the user is not a member' do
        let!(:group) { Fabricate :group }
        let!(:presentation) { Fabricate :presentation, group: group }

        before { get :play, params: { id: presentation } }

        it 'does not show the play page' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end
  end
end
