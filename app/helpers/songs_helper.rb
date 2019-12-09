module SongsHelper
  def get_tags_from_songs(songs)
    tags = songs.map(&:tags)
    tags.flatten.uniq
  end

  def can_delete_song?(song)
    song.persisted? && song.presentations.empty?
  end
end
