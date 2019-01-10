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
  has_many :presentation_songs, -> { order(:index) }, inverse_of: :presentation, dependent: :destroy
  has_many :songs, through: :presentation_songs
  has_many :comments, as: :target
  validates :local, :date_time, :group, :presentation_songs, presence: true
  validate :validate_date_time

  def add_song(song)
    index = presentation_songs.size + 1
    presentation_songs.build(song: song, index: index)
  end

  def validate_date_time
    if date_time && date_time < DateTime.now
      errors.add(:date_time, :invalid_date_time)
    end
  end
end
