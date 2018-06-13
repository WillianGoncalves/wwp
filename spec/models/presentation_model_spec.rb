require 'rails_helper'

RSpec.describe Presentation, type: :model do
  it { is_expected.to have_many :songs }
  it { is_expected.to have_many :comments }
  it { is_expected.to belong_to :group }
  it { is_expected.to validate_presence_of :date_time }

  describe 'add_song' do
    let!(:song) { Fabricate :song }
    let!(:presentation) { Presentation.new }

    before { presentation.add_song(song) }

    it 'adds the song to presentation' do
      expect(presentation.presentation_songs.size).to eq 1
    end
  end
end
