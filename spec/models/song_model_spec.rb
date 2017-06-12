# frozen_string_literal: true
RSpec.describe Song, type: :model do
  it { is_expected.to have_and_belong_to_many :tags }
  it { is_expected.to have_and_belong_to_many :presentations }
  it { is_expected.to have_many :comments }
  it { is_expected.to belong_to :group }
  it { is_expected.to validate_presence_of :title }
end