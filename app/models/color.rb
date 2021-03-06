# == Schema Information
#
# Table name: colors
#
#  id         :integer          not null, primary key
#  name       :string
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_colors_on_code  (code) UNIQUE
#  index_colors_on_name  (name) UNIQUE
#

class Color < ApplicationRecord
  has_many :tags, dependent: :restrict_with_exception
  validates :name, :code, presence: true
  validates :code, :name, uniqueness: true
end
