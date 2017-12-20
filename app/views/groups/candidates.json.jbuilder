json.array! @candidates do |c|
  json.id c.id
  json.first_name c.first_name
  json.last_name c.last_name
  json.avatar_url c.avatar.url
end
