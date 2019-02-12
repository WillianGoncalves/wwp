# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  admin      :boolean
#  user_id    :integer          not null
#  group_id   :integer          not null
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

require 'rails_helper'

RSpec.describe Member, type: :model do
  before(:all) do
    Fabricate :group
    Fabricate :user
  end
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :group }
  it { is_expected.to validate_uniqueness_of(:user).scoped_to(:group_id) }
end
