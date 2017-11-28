# frozen_string_literal: true
RSpec.describe PresentationSong, type: :model do
  it { is_expected.to belong_to :presentation }
  it { is_expected.to belong_to :song }
  it { is_expected.to validate_numericality_of :index }
end
