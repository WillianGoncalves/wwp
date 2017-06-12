# frozen_string_literal: true
RSpec.describe Tag, type: :model do
  it { is_expected.to belong_to :color }
  it { is_expected.to have_and_belong_to_many :songs }
  it { is_expected.to validate_presence_of :name }
end
