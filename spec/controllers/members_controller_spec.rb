require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let!(:user) { Fabricate :user }

  before { sign_in user }

  describe 'POST #create' do
    context 'with invalid values' do
      let!(:member_admin) { Fabricate.build :member_admin, user: user }
      let!(:group) { Fabricate :group, members: [member_admin] }
      let!(:user1) { Fabricate :user }
      let!(:valid_member) { { user_id: user1 } }
      let!(:invalid_member) { { user_id: nil } }

      before { post :create, params: { group_id: group, members: [valid_member, invalid_member], format: :json } }

      it { expect(response).to have_http_status :bad_request }
      it { expect(group.reload.members.count).to eq 1 }
      it { expect(user1.groups.count).to eq 0 }
    end

    context 'with valid values' do
      let!(:member_admin) { Fabricate.build :member_admin, user: user }
      let!(:group) { Fabricate :group, members: [member_admin] }
      let!(:user1) { Fabricate :user }
      let!(:user2) { Fabricate :user }
      let!(:member1) { { user_id: user1.id } }
      let!(:member2) { { user_id: user2.id } }

      before { post :create, params: { group_id: group, members: [member1, member2], format: :json } }

      it { expect(response).to have_http_status :no_content }
      it { expect(group.reload.members.count).to eq 3 }
      it { expect(user1.groups.count).to eq 1 }
      it { expect(user2.groups.count).to eq 1 }
    end
  end

  describe 'DELETE #destroy' do
    let!(:member_admin) { Fabricate.build :member_admin, user: user }
    let!(:user1) { Fabricate :user }
    let!(:user2) { Fabricate :user }
    let!(:member1) { Fabricate.build :member, user: user1 }
    let!(:member2) { Fabricate.build :member, user: user2 }
    let!(:group) { Fabricate :group, members: [member_admin, member1, member2] }

    before { delete :destroy, params: { group_id: group, id: member1.id } }

    it { expect(response).to redirect_to group_path(group) }
    it { expect(group.reload.members).to match_array [member_admin, member2] }
    it { expect(group.reload.members).to_not include member1 }
  end
end
