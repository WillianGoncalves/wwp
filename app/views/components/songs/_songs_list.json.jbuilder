json.array! songs.each do |song|
  json.(song, :id, :title, :author, :tone)
  json.tags song.tags.each do |tag|
    json.(tag, :name)
    json.color do
      json.(tag.color, :code)
    end
  end
end
