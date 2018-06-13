require 'rails_helper'

RSpec.describe JoinRequestsController, type: :controller do
  context 'with unauthenticated user' do
    let!(:user) { Fabricate :user }
    let!(:group) { Fabricate :group, admin: user }

    describe 'GET #index' do
      before { get :index, params: { group_id: group }}

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'POST #create' do
      let!(:join_request) { { accepted: nil } }

      before { post :create, params: { group_id: group, join_request: join_request, format: :json } }

      it 'redirects to login page' do
        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'PUT #accept' do
      let!(:pending_join_request) { Fabricate :pending_join_request, group: group }

      before { put :accept, params: { id: pending_join_request } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'PUT #reject' do
      let!(:pending_join_request) { Fabricate :pending_join_request, group: group }

      before { put :reject, params: { id: pending_join_request } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  context 'with authenticated user' do
    let!(:user) { Fabricate :user }

    before { sign_in user }

    describe 'GET #index' do
      context 'when the user is the admin' do
        let!(:group) { Fabricate :group, admin: user }
        let!(:pending_join_request) { Fabricate :pending_join_request, group: group }
        let!(:accepted_join_request) { Fabricate :accepted_join_request, group: group }

        before { get :index, params: { group_id: group } }

        it 'lists all join requests not yet accepted' do
          expect(response).to render_template :index
          expect(assigns(:join_requests)).to match_array [ pending_join_request ]
        end
      end

      context 'when the user is not the admin' do
        let!(:group) { Fabricate :group, member: user }

        before { get :index, params: { group_id: group } }

        it 'does not list the join requests' do
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe 'POST #create' do
      context 'when the user is not yet a member' do
        let!(:group) { Fabricate :group }
        let(:join_request) { { accepted: nil } }

        before { post :create, params: { group_id: group, join_request: join_request, format: :json } }

        it 'creates a join request' do
          expect(response).to have_http_status :ok
          expect(group.join_requests.count).to eq 1
          expect(group.join_requests_to_be_accepted.count).to eq 1
        end
      end

      context 'when the user is the admin' do
        let!(:group) { Fabricate :group, admin: user }
        let(:join_request) { { accepted: nil } }

        before { post :create, params: { group_id: group, join_request: join_request, format: :json } }

        it 'does not create a join request' do
          expect(response).to have_http_status :bad_request
          expect(group.join_requests.count).to eq 0
          expect(group.join_requests_to_be_accepted.count).to eq 0
        end
      end

      context 'when there is already a join request' do
        let!(:group) { Fabricate :group }
        let!(:pending_join_request) { Fabricate :pending_join_request, group: group, user: user }
        let(:join_request) { { accepted: nil } }

        before { post :create, params: { group_id: group, join_request: join_request, format: :json } }

        it 'does not create a join request' do
          expect(response).to have_http_status :bad_request
          expect(group.join_requests.count).to eq 1
          expect(group.join_requests_to_be_accepted.count).to eq 1
        end
      end
    end

    describe 'PUT #accept' do
      context 'when the user is not the admin' do
        let!(:group) { Fabricate :group, member: user }
        let!(:pending_join_request) { Fabricate :pending_join_request, group: group }

        before { put :accept, params: { id: pending_join_request } }

        it 'does not accept a join request' do
          expect(response).to redirect_to root_path
          expect(group.members.count).to eq 2
          expect(pending_join_request.reload.accepted).to eq nil
          expect(flash[:alert]).to be_present
        end
      end

      context 'when the user is the admin' do
        let!(:group) { Fabricate :group, admin: user }

        context 'with a pending join request' do
          let!(:pending_join_request) { Fabricate :pending_join_request, group: group }

          before { put :accept, params: { id: pending_join_request } }

          it 'accepts a join request' do
            expect(response).to redirect_to group_join_requests_path(group)
            expect(group.members.count).to eq 2
            expect(pending_join_request.reload.accepted).to eq true
          end
        end

        context 'with a refused join request' do
          let!(:refused_join_request) { Fabricate :refused_join_request, group: group }

          before { put :accept, params: { id: refused_join_request } }

          it 'does not accepts the join request' do
            expect(response).to redirect_to group_join_requests_path(group)
            expect(group.members.count).to eq 1
            expect(refused_join_request.reload.accepted).to eq false
          end
        end

        context 'with an already accepted join request' do
          let!(:accepted_join_request) { Fabricate :accepted_join_request, group: group }

          before { put :accept, params: { id: accepted_join_request } }

          it 'does not change the join request' do
            expect(response).to redirect_to group_join_requests_path(group)
            expect(group.members.count).to eq 2
            expect(accepted_join_request.reload.accepted).to eq true
          end
        end
      end
    end

    describe 'PUT #reject' do
      context 'when the user is not the admin' do
        let!(:group) { Fabricate :group, member: user }
        let!(:pending_join_request) { Fabricate :pending_join_request, group: group }

        before { put :accept, params: { id: pending_join_request } }

        it 'does not accept a join request' do
          expect(response).to redirect_to root_path
          expect(group.members.count).to eq 2
          expect(pending_join_request.reload.accepted).to eq nil
          expect(flash[:alert]).to be_present
        end
      end

      context 'when the user is the admin' do
        let!(:group) { Fabricate :group, admin: user }

        context 'with a pending join request' do
          let!(:pending_join_request) { Fabricate :pending_join_request, group: group }

          before { put :reject, params: { id: pending_join_request } }

          it 'rejects the join request' do
            expect(response).to redirect_to group_join_requests_path(group)
            expect(group.members.count).to eq 1
            expect(pending_join_request.reload.accepted).to eq false
          end
        end

        context 'with an accepted join request' do
          let!(:accepted_join_request) { Fabricate :accepted_join_request, group: group }

          before { put :reject, params: { id: accepted_join_request } }

          it 'does not reject the join request' do
            expect(response).to redirect_to group_join_requests_path(group)
            expect(group.members.count).to eq 2
            expect(accepted_join_request.reload.accepted).to eq true
          end
        end

        context 'with an already refused join request' do
          let!(:refused_join_request) { Fabricate :refused_join_request, group: group }

          before { put :reject, params: { id: refused_join_request } }

          it 'does not change the join request' do
            expect(response).to redirect_to group_join_requests_path(group)
            expect(group.members.count).to eq 1
            expect(refused_join_request.reload.accepted).to eq false
          end
        end
      end
    end
  end
end
