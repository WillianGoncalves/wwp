# frozen_string_literal: true
RSpec.describe User, type: :model do
  it { is_expected.to have_many :members }
  it { is_expected.to have_many :join_requests }
  it { is_expected.to have_many :comments }
  it { is_expected.to belong_to :last_group }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
end
