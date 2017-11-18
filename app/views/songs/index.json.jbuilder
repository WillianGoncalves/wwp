json.array! @songs do |s|
  json.(s, :id, :title, :author, :tone)
  json.tags s.tags do |t|
    json.id t.id
    json.name t.name
    json.color t.color.code
  end
end
