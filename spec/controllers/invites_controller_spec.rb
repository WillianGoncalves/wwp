require 'rails_helper'

RSpec.describe InvitesController, type: :controller do

  let!(:user) { Fabricate :user }

  before { sign_in user }

  describe 'POST #create' do
    context 'with invalid values' do
      let!(:group) { Fabricate :group }
      let!(:user1) { Fabricate :user }
      let!(:valid_invite) { { user_id: user1 } }
      let!(:invalid_invite) { { user_id: nil } }

      before { post :create, params: { group_id: group, invites: [valid_invite, invalid_invite], format: :json } }

      it { expect(response).to have_http_status :bad_request }
      # it { expect(response).to render_template "groups/show" }
      it { expect(group.invites.count).to eq 0 }
      it { expect(user1.invites.count).to eq 0 }
    end

    context 'with valid values' do
      let!(:group) { Fabricate :group }
      let!(:user1) { Fabricate :user }
      let!(:user2) { Fabricate :user }
      let!(:invite1) { { user_id: user1.id } }
      let!(:invite2) { { user_id: user2.id } }

      before { post :create, params: { group_id: group, invites: [invite1, invite2], format: :json } }

      it { expect(response).to have_http_status :ok }
      it { expect(group.invites.count).to eq 2 }
      it { expect(user1.invites.count).to eq 1 }
      it { expect(user2.invites.count).to eq 1 }
    end
  end
end
