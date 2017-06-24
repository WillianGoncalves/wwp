json.array! groups do |g|
  json.(g, :id, :name)

  json.members g.members do |m|
    json.avatar_url m.user.avatar.standard.url
  end
end
