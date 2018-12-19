# frozen_string_literal: true
json.call(comment, :id, :body)
json.created_at comment.created_at.strftime('%d/%m/%Y')
json.commenter do
  json.full_name comment.commenter.full_name
  json.avatar_url comment.commenter.avatar.url
end
