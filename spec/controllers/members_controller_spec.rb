require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  context 'with unauthenticated user' do
    describe 'POST #create' do
      let!(:group) { Fabricate :group }
      let!(:user1) { Fabricate :user }
      let!(:member1) { { user_id: user1.id } }

      before { post :create, params: { group_id: group, members: [ member1 ], format: :json } }

      it 'redirects to login page' do
        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'DELETE #destroy' do
      let(:member) { Fabricate.build :member }
      let!(:group) { Fabricate :group, members: [ member ] }

      before { delete :destroy, params: { group_id: group, id: member } }

      it 'redirects to login page' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  context 'with authenticated user' do
    let!(:user) { Fabricate :user }

    before { sign_in user }

    describe 'POST #create' do
      context 'when the user is the admin' do
        let!(:group) { Fabricate :group, admin: user }

        context 'with invalid data' do
          let!(:user1) { Fabricate :user }
          let(:valid_data) { { user_id: user1 } }
          let(:invalid_data) { { user_id: nil } }

          before { post :create, params: { group_id: group, members: [valid_data, invalid_data], format: :json } }

          it 'does not add the members' do
            expect(response).to have_http_status :bad_request
            expect(group.members.count).to eq 1
            expect(user1.groups.count).to eq 0
          end
        end

        context 'with valid data' do
          let!(:user1) { Fabricate :user }
          let!(:user2) { Fabricate :user }
          let!(:member1) { { user_id: user1.id } }
          let!(:member2) { { user_id: user2.id } }

          before { post :create, params: { group_id: group, members: [member1, member2], format: :json } }

          it 'adds the members' do
            expect(response).to have_http_status :no_content
            expect(group.members.count).to eq 3
            expect(user1.groups.count).to eq 1
            expect(user2.groups.count).to eq 1
          end
        end

        context 'when the user is already a member' do
          let!(:user1) { Fabricate :user }
          let!(:member1) { { user_id: user1.id } }

          before { group.add_member!(user1) }
          before { post :create, params: { group_id: group, members: [member1], format: :json } }

          it 'does not add the member' do
            expect(response).to have_http_status :bad_request
            expect(group.members.count).to eq 2
          end
        end
      end

      context 'when the user is not the admin' do
        let!(:group) { Fabricate :group }
        let!(:user1) { Fabricate :user }
        let!(:member1) { { user_id: user1.id } }

        before { post :create, params: { group_id: group, members: [member1], format: :json } }

        it 'does not add the member' do
          expect(response).to have_http_status :bad_request
          expect(group.members.count).to eq 1
          expect(user1.groups.count).to eq 0
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'when the user is the admin' do
        let(:member) { Fabricate.build :member }
        let!(:group) { Fabricate :group, admin: user, members: [ member ] }

        before { delete :destroy, params: { group_id: group, id: member } }

        it 'removes the member from group' do
          expect(response).to redirect_to group_path(group)
          expect(group.members.count).to eq 1
          expect(group.reload.members).to_not include member
        end
      end

      context 'when the user is not the admin' do
        let(:member) { Fabricate.build :member }
        let!(:group) { Fabricate :group, members: [ member ] }

        before { delete :destroy, params: { group_id: group, id: member } }

        it 'does not remove the member from group' do
          expect(response).to redirect_to root_path
          expect(group.reload.members).to include member
          expect(flash[:alert]).to be_present
        end
      end
    end
  end
end
