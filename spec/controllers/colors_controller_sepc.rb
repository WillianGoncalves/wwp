require 'rails_helper'

RSpec.describe ColorsController, type: :controller do
  context 'with unauthenticated user' do
    describe 'GET #index' do
      before { get :index, params: { format: :json } }

      it 'does not list colors' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  context 'with authenticated user' do
    let!(:user) { Fabricate :user }

    before { sign_in user }

    describe 'GET #index' do
      before { get :index, params: { format: :json } }

      it 'lists colors' do
        expect(response).to have_http_status :ok
        expect(response.content_type).to eq 'application/json'
      end
    end
  end
end
