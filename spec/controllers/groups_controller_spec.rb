require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  context 'unauthenticated user' do
    describe 'GET #index' do
      before { get :index }
      it { expect(response).to redirect_to user_session_path }
    end
  end

  context 'authenticated user' do
    let(:user) { Fabricate :user }

    before { sign_in user }

    describe 'GET #index' do
      before { get :index }
      it { expect(response.status).to be(200) }
    end
  end
end
