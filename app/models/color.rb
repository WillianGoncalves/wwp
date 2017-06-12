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

class Color < ApplicationRecord
  validates :name, :code, presence: true
end
