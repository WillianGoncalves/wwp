# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  title      :string
#  author     :string
#  tone       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :integer          not null
#  deleted_at :datetime
#
# Indexes
#
#  index_songs_on_deleted_at  (deleted_at)
#  index_songs_on_group_id    (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#

class Song < ApplicationRecord
  acts_as_paranoid

  belongs_to :group
  has_and_belongs_to_many :tags
  has_many :presentation_songs
  has_many :presentations, through: :presentation_songs
  has_many :comments, -> { order(:created_at) }, as: :target
  validates :title, :group, presence: true
  validates :tone, format: { with: /\A[A-G](b|#)?m?\z/ }
end
