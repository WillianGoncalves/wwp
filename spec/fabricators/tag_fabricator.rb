# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  color_id   :integer          not null
#  group_id   :integer
#
# Indexes
#
#  index_tags_on_color_id  (color_id)
#  index_tags_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#

Fabricator(:tag) do
  name { Faker::Lorem.word }
  color
end
