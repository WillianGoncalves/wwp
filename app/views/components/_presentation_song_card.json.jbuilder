json.(presentation_song, :id, :index)
json.(presentation_song.song, :title, :author, :tone)
json.tags presentation_song.song.tags.each do |tag|
  json.(tag, :name)
  json.color do
    json.(tag.color, :code)
  end
end
