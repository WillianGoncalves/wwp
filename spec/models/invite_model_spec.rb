# frozen_string_literal: true
RSpec.describe Invite, type: :model do
  it { is_expected.to belong_to :group }
  it { is_expected.to belong_to :user }
end
