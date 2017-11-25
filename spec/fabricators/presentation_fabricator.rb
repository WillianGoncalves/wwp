# == Schema Information
#
# Table name: presentations
#
#  id         :integer          not null, primary key
#  local      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :integer          not null
#  deleted_at :datetime
#  date_time  :datetime
#
# Indexes
#
#  index_presentations_on_deleted_at  (deleted_at)
#  index_presentations_on_group_id    (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#

Fabricator(:presentation) do
  date_time Faker::Date.forward(10)
  local Faker::Address.city
end
