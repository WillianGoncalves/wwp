# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  color_id   :integer          not null
#
# Indexes
#
#  index_tags_on_color_id  (color_id)
#

class Tag < ApplicationRecord
  belongs_to :color
  has_and_belongs_to_many :songs
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :color, uniqueness: true
end
