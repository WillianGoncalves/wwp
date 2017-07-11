# == Schema Information
#
# Table name: join_requests
#
#  id         :integer          not null, primary key
#  accepted   :boolean
#  group_id   :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_join_requests_on_group_id  (group_id)
#  index_join_requests_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#

class JoinRequest < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :group, :user, presence: true
end
