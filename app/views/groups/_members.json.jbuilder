json.array! members do |m|
  json.id m.id
  json.first_name m.user.first_name
  json.last_name m.user.last_name
  json.avatar_url m.user.avatar.standard.url
end
