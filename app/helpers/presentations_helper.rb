module PresentationsHelper
  def song_ids(presentation)
    song_ids = presentation.presentation_songs.map { |presentation_song| presentation_song.song.id }
    song_ids.join(",")
  end

  def months
    months = I18n.t('date.month_names').to_a.compact
    months.unshift(I18n.t('date.all_months'))
    months.each_with_index.map{ |month, index| [month, index] }
  end

  def years
    Presentation.all.map { |p| p.date_time.year }.uniq
  end

  def past_presentation_time(presentation)
    return if presentation.nil?
    prefix = t('date.time_ago_prefix')
    time_past = time_ago_in_words(presentation.date_time)
    "#{prefix} #{time_past}"
  end

  def time_until_presentation(presentation)
    return if presentation.nil?
    prefix = t('date.from_now_prefix')
    time_until = time_ago_in_words(presentation.date_time)
    "#{prefix} #{time_until}"
  end

  def presentation_date_with_day_of_week(presentation)
    "#{l(presentation.date_time, format: '%A')}, #{presentation.date_time&.strftime('%d/%m/%Y')}"
  end

  def presentation_date(presentation)
    presentation.date_time&.strftime('%d/%m/%Y')
  end

  def presentation_time(presentation)
    presentation.date_time&.strftime('%H:%M')
  end
end
