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

Fabricator(:tag) do
  name { Faker::Lorem.word }
  color
end
