module SongsHelper
  def get_tags_from_songs(songs)
    tags = songs.map(&:tags)
    tags.flatten.uniq
  end
end
