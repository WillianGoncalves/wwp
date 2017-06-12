# frozen_string_literal: true
RSpec.describe Color, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :code }
end
