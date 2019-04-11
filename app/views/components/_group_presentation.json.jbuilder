# frozen_string_literal: true
json.call(presentation, :id, :local)
json.date presentation.date_time.strftime('%d/%m/%Y')
json.time presentation.date_time.strftime('%H:%M')
json.songs presentation.presentation_songs do |ps|
  json.index ps.index
  json.title ps.song.title
  json.author ps.song.author
end
