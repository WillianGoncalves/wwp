# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
# Indexes
#
#  index_groups_on_deleted_at  (deleted_at)
#

Fabricator(:group) do
  transient :admin, :member
  name { Faker::Music::RockBand.name }

  before_validation do |group, transients|
    group_admin = transients[:admin] || Fabricate(:user)
    group.add_admin(group_admin)
  end

  after_create do |group, transients|
    if transients[:member]
      group.add_member!(transients[:member])
    end
  end
end
