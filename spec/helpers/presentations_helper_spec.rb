require 'rails_helper'

RSpec.describe PresentationsHelper, type: :helper do
  describe "song_ids" do
    let!(:user) { Fabricate :user }
    let!(:member) { Fabricate.build :member_admin, user: user }
    let!(:group) { Fabricate :group, members: [member]  }
    let!(:song1) { Fabricate :song, group: group }
    let!(:song2) { Fabricate :song, group: group }
    let!(:presentation_song1) { PresentationSong.new(song: song1, index: 0) }
    let!(:presentation_song2) { PresentationSong.new(song: song2, index: 1) }
    let!(:presentation) { Fabricate :presentation, group: group, presentation_songs: [ presentation_song1, presentation_song2 ] }

    it { expect(helper.song_ids(presentation)).to eq "#{song1.id},#{song2.id}" }
  end
end
