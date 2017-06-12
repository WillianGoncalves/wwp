# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  admin      :boolean
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_members_on_group_id  (group_id)
#  index_members_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#

class Member < ApplicationRecord
  belongs_to :user
  belongs_to :group
end