# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  has_many :invites, inverse_of: :group
  has_many :presentations, inverse_of: :group
  has_many :songs
  has_many :members
  has_many :users, through: :members
  validates :name, presence: true
end
