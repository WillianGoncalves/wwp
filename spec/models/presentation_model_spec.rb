# frozen_string_literal: true
RSpec.describe Presentation, type: :model do
  it { is_expected.to have_many :songs }
  it { is_expected.to have_many :comments }
  it { is_expected.to belong_to :group }
  it { is_expected.to validate_presence_of :date_time }
end
