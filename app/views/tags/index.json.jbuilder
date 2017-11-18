json.array! @tags do |t|
  json.(t, :id, :name)
  json.color t.color.code
end
