module PresentationsHelper
  def song_ids(presentation)
    song_ids = presentation.presentation_songs.map { |presentation_song| presentation_song.song.id }
    song_ids.join(",")
  end
end
