# == Schema Information
#
# Table name: presentations
#
#  id         :integer          not null, primary key
#  local      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :integer          not null
#  deleted_at :datetime
#  date_time  :datetime
#
# Indexes
#
#  index_presentations_on_deleted_at  (deleted_at)
#  index_presentations_on_group_id    (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#

class Presentation < ApplicationRecord
  acts_as_paranoid

  belongs_to :group
  has_many :presentation_songs, -> { order(:index) }, inverse_of: :presentation
  has_many :songs, through: :presentation_songs
  has_many :comments, as: :target
  validates :date_time, :group, :presentation_songs, presence: true

  def add_song(song)
    index = self.songs.count
    self.presentation_songs.build(song: song, index: index)
  end
end
