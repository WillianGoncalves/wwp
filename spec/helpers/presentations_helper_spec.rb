require 'rails_helper'

RSpec.describe PresentationsHelper, type: :helper do
  describe "song_ids" do
    let!(:group) { Fabricate :group  }
    let!(:presentation) { Fabricate :presentation, group: group }

    it { expect(helper.song_ids(presentation)).to match (/\d/) }
  end
end
