require 'rails_helper'

RSpec.describe PresentationSong, type: :model do
  before(:all) do
     group = Fabricate :group
     Fabricate :presentation, group: group
  end
  it { is_expected.to belong_to :presentation }
  it { is_expected.to belong_to :song }
  it { is_expected.to validate_numericality_of :index }
  it { is_expected.to validate_uniqueness_of(:song).scoped_to(:presentation_id) }
end
