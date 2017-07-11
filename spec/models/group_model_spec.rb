# frozen_string_literal: true
RSpec.describe Group, type: :model do
  it { is_expected.to have_many :members }
  it { is_expected.to have_many :songs }
  it { is_expected.to have_many :presentations }
  it { is_expected.to have_many :join_requests }
  it { is_expected.to validate_presence_of :name }
end
