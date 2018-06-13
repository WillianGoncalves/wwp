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
end
