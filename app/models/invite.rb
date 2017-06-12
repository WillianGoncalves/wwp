# == Schema Information
#
# Table name: invites
#
#  id         :integer          not null, primary key
#  accepted   :boolean
#  group_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_invites_on_group_id  (group_id)
#  index_invites_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#

class Invite < ApplicationRecord
  belongs_to :group
  belongs_to :user
end
