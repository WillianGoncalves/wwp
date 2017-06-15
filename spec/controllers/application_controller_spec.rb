require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#after_sign_in_path_for' do
    context 'without group' do
      let(:user) { Fabricate :user }
      it { expect(controller.after_sign_in_path_for(user)).to eq groups_path }
    end

    context 'with last group' do
      let(:last_group) { Fabricate :group }
      let(:user) { Fabricate :user, last_group: last_group }
      it { expect(controller.after_sign_in_path_for(user)).to eq group_path(user.last_group) }
    end
  end
  
  # describe '#configure_permitted_parameters' do
  #   controller(Devise::RegistrationsController) do
  #   end
  #   before { @request.env['devise.mapping'] = Devise.mappings[:user] }
  #   it 'adds the necessary fields to the permitted params' do
  #     expect(controller.devise_parameter_sanitizer).to receive(:permit).with(:sign_up, keys: [:first_name, :last_name, :avatar])
  #     get :new
  #   end
  # end
end
