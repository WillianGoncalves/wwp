json.(presentation_song, :id, :index)
json.(presentation_song.song, :title, :author, :tone)
json.tags presentation_song.song.tags.each do |tag|
  json.partial! 'songs/tag', tag: tag
end
