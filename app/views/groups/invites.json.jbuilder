json.array! invites do |i|
  json.id i.id
  json.avatar_url i.user.avatar.standard.url
end
