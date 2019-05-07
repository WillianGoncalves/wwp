# == Schema Information
#
# Table name: presentation_songs
#
#  id              :bigint(8)        not null, primary key
#  presentation_id :bigint(8)
#  song_id         :bigint(8)
#  index           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_presentation_songs_on_presentation_id  (presentation_id)
#  index_presentation_songs_on_song_id          (song_id)
#
# Foreign Keys
#
#  fk_rails_...  (presentation_id => presentations.id)
#  fk_rails_...  (song_id => songs.id)
#

class PresentationSong < ApplicationRecord
  belongs_to :presentation
  belongs_to :song
  validates :index, numericality: { only_integer: true }
  validates :song, uniqueness: { scope: :presentation_id }
end
