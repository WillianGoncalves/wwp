# frozen_string_literal: true
RSpec.describe JoinRequest, type: :model do
  it { is_expected.to belong_to :group }
  it { is_expected.to belong_to :user }
end
