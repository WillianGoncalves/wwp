json.array! groups do |g|
  json.(g, :id, :name)

  json.members g.members do |m|
    json.id m.id
    json.avatar_url m.user.avatar.url
  end
end
