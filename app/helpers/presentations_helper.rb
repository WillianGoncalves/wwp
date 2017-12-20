module PresentationsHelper
  def song_ids(presentation)
    song_ids = presentation.presentation_songs.map { |presentation_song| presentation_song.song.id }
    song_ids.join(",")
  end

  def months
    months = I18n.t('date.month_names').to_a.compact
    options = []
    months.each_with_index do |month, index|
      options << [ month, index + 1 ]
    end
    return options
  end

  def years
    Presentation.all.map { |p| p.date_time.year }.uniq
  end
end
