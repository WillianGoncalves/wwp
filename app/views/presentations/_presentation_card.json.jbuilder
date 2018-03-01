json.(presentation, :time, :local)
json.day presentation.date_time.day
json.month I18n.l(presentation.date_time, format: "%b")
