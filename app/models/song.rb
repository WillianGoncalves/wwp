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
#  group_id   :integer
#
# Indexes
#
#  index_songs_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#

class Song < ApplicationRecord
  belongs_to :group
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :presentations
  has_many :comments, as: :target
  validates :title, presence: true
end
