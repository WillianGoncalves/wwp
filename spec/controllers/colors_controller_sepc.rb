require 'rails_helper'

RSpec.describe ColorsController, type: :controller do
  let!(:user) { Fabricate :user }

  before { sign_in user }

  describe 'GET #index' do
    before { get :index, params: { format: :json } }

    it { expect(response).to have_http_status :ok }
    it { expect(response.content_type).to eq 'application/json' }
  end
end
