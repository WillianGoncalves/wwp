module SongsHelper
  def get_tags_from_songs(songs)
    tags = songs.map{ |song| song.tags }
    tags.flatten.uniq
  end
end
