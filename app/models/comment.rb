# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  body        :text
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  target_type :string           not null
#  target_id   :integer          not null
#
# Indexes
#
#  index_comments_on_target_type_and_target_id  (target_type,target_id)
#  index_comments_on_user_id                    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User", foreign_key: "user_id"
  belongs_to :target, polymorphic: true
  validates :body, :commenter, :target, presence: true
end
