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

Fabricator(:color) do
  name { Faker::Color.color_name }
  code { Faker::Color.hex_color }
end
