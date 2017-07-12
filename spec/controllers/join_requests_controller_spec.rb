require 'rails_helper'

RSpec.describe JoinRequestsController, type: :controller do
  let!(:user) { Fabricate :user }

  before { sign_in user }

  describe 'GET #index' do
    let!(:user1) { Fabricate :user }
    let!(:join_request1) { JoinRequest.new(user_id: user1.id, accepted: nil) }
    let!(:user2) { Fabricate :user }
    let!(:join_request2) { JoinRequest.new(user_id: user2.id, accepted: true) }
    let!(:user3) { Fabricate :user }
    let!(:join_request3) { JoinRequest.new(user_id: user3.id, accepted: false) }
    let!(:group) { Fabricate :group, join_requests: [join_request1, join_request2, join_request3] }

    before { get :index, params: { group_id: group } }

    it { expect(response).to render_template :index }
    it { expect(assigns(:join_requests).count).to eq 1 }
    it { expect(assigns(:join_requests)).to include join_request1 }
    it { expect(assigns(:join_requests)).to_not include join_request2 }
    it { expect(assigns(:join_requests)).to_not include join_request3 }
  end

  describe 'POST #create' do
    let!(:group) { Fabricate :group }
    let!(:join_request) { { accepted: nil } }

    before { post :create, params: { group_id: group, join_request: join_request, format: :json } }

    it { expect(response).to have_http_status :ok }
    it { expect(group.reload.join_requests.count).to eq 1 }
    it { expect(group.join_requests_to_be_accepted.count).to eq 1 }
    it { expect(user.reload.join_requests.count).to eq 1 }
  end

  describe 'PUT #aprove' do
    context 'with many join requests to be accepted' do
      let!(:user1) { Fabricate :user }
      let!(:join_request1) { JoinRequest.new(user_id: user1.id, accepted: nil) }
      let!(:user2) { Fabricate :user }
      let!(:join_request2) { JoinRequest.new(user_id: user2.id, accepted: nil) }
      let!(:user3) { Fabricate :user }
      let!(:join_request3) { JoinRequest.new(user_id: user3.id, accepted: nil) }
      let!(:member) { Fabricate.build :member_admin, user: user }
      let!(:group) { Fabricate :group, join_requests: [join_request1, join_request2, join_request3], members: [member] }

      before { put :accept, params: { id: join_request1.id } }

      it { expect(response).to redirect_to group_join_requests_path(group) }
      it { expect(group.members.count).to eq 2 }
      it { expect(join_request1.reload.accepted).to eq true }
    end

    context 'with one join requests to be accepted' do
      let!(:user1) { Fabricate :user }
      let!(:join_request1) { JoinRequest.new(user_id: user1.id, accepted: nil) }
      let!(:member) { Fabricate.build :member_admin, user: user }
      let!(:group) { Fabricate :group, join_requests: [join_request1], members: [member] }

      before { put :accept, params: { id: join_request1.id } }

      it { expect(response).to redirect_to group_path(group) }
      it { expect(group.members.count).to eq 2 }
      it { expect(join_request1.reload.accepted).to eq true }
    end
  end

  describe 'PUT #reject' do
    context 'with many join requests to be accepted' do
      let!(:user1) { Fabricate :user }
      let!(:join_request1) { JoinRequest.new(user_id: user1.id, accepted: nil) }
      let!(:user2) { Fabricate :user }
      let!(:join_request2) { JoinRequest.new(user_id: user2.id, accepted: nil) }
      let!(:user3) { Fabricate :user }
      let!(:join_request3) { JoinRequest.new(user_id: user3.id, accepted: nil) }
      let!(:member) { Fabricate.build :member_admin, user: user }
      let!(:group) { Fabricate :group, join_requests: [join_request1, join_request2, join_request3], members: [member] }

      before { put :reject, params: { id: join_request1.id } }

      it { expect(response).to redirect_to group_join_requests_path(group) }
      it { expect(group.members.count).to eq 1 }
      it { expect(join_request1.reload.accepted).to eq false }
    end

    context 'with one join requests to be accepted' do
      let!(:user1) { Fabricate :user }
      let!(:join_request1) { JoinRequest.new(user_id: user1.id, accepted: nil) }
      let!(:member) { Fabricate.build :member_admin, user: user }
      let!(:group) { Fabricate :group, join_requests: [join_request1], members: [member] }

      before { put :reject, params: { id: join_request1.id } }

      it { expect(response).to redirect_to group_path(group) }
      it { expect(group.members.count).to eq 1 }
      it { expect(join_request1.reload.accepted).to eq false }
    end
  end
end
