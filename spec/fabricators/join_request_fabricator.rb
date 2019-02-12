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
#  index_join_requests_on_group_id              (group_id)
#  index_join_requests_on_user_id               (user_id)
#  index_join_requests_on_user_id_and_group_id  (user_id,group_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#

Fabricator(:pending_join_request, from: :join_request) do
  user
  accepted nil
end

Fabricator(:accepted_join_request, from: :pending_join_request) do
  accepted true
  before_create do |join_request|
    join_request.group.add_member!(join_request.user)
  end
end

Fabricator(:refused_join_request, from: :pending_join_request) do
  accepted false
end
