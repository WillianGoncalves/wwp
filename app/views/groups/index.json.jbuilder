json.array! @groups do |g|
  json.(g, :id, :name)

  json.members g.members do |m|
    json.first_name m.user.first_name
    json.last_name m.user.last_name
    json.avatar_url m.user.avatar.standard.url
  end

  json.songs g.songs do |s|
    json.(s, :id, :title)
  end
end
