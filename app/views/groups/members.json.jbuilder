json.array! members do |m|
  json.id m.id
  json.avatar_url m.user.avatar.standard.url
end
