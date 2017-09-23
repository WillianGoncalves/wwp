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
#  group_id   :integer          not null
#  deleted_at :datetime
#
# Indexes
#
#  index_songs_on_deleted_at  (deleted_at)
#  index_songs_on_group_id    (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#

Fabricator(:song) do
  title Faker::BossaNova.song
  author Faker::Name.name
  tone Faker::Music.key
end
