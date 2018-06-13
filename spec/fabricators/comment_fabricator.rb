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

Fabricator(:song_comment, from: :comment) do
  body { Faker::Lorem.sentences }
  commenter { Fabricate :user }
  target { Fabricate :song }
end

Fabricator(:presentation_comment, from: :comment) do
  body { Faker::Lorem.sentences }
  commenter { Fabricate :user }
  target { Fabricate :presentation }
end
