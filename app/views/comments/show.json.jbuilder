json.(comment, :id, :body)
json.commenter do
  json.id comment.commenter.id
  json.first_name comment.commenter.first_name
  json.last_name comment.commenter.last_name
  json.avatar_url comment.commenter.avatar.url
end
