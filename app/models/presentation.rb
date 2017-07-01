# == Schema Information
#
# Table name: presentations
#
#  id         :integer          not null, primary key
#  date       :date
#  time       :time
#  local      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :integer          not null
#
# Indexes
#
#  index_presentations_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#

class Presentation < ApplicationRecord
  belongs_to :group
  has_and_belongs_to_many :songs
  has_many :comments, as: :target
  validates :date, :time, :group, presence: true
end
