require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  context 'unauthenticated user' do
    describe 'GET #index' do
      before { get :index }
      it { expect(response).to redirect_to user_session_path }
    end

    describe 'GET #show' do
      before { get :show, params: { id: 1 } }
      it { expect(response).to redirect_to user_session_path }
    end
  end

  context 'authenticated user' do

    let!(:user) { Fabricate :user }

    before { sign_in user }

    describe 'GET #index' do
      let!(:member) { Fabricate.build :member_admin, user: user }
      let!(:group1) { Fabricate :group, members: [member]  }
      let!(:group2) { Fabricate :group }

      before { get :index }

      it { expect(response.status).to render_template :index }
      it { expect(user.groups).to match_array [group1] }
      it { expect(assigns(:groups)).to match_array [group2] }
    end

    describe 'GET #show' do
      context 'with a group that includes current user' do
        let!(:member) { Fabricate.build :member_admin, user: user }
        let!(:group) { Fabricate :group, members: [member]  }

        before { get :show, params: { id: group } }

        it { expect(response).to render_template :show }
        it { expect(assigns(:group)).to eq group }
        it { expect(user.reload.last_group).to eq group }
      end

      context 'with a group that does not include current user' do
        let!(:group) { Fabricate :group }

        before { get :show, params: { id: group } }

        it { expect(response).to render_template :show }
        it { expect(assigns(:group)).to eq group }
        it { expect(user.reload.last_group).to eq nil }
      end
    end
  end
end
