if group.present?
  json.(group, :id, :name)
  json.tags group.tags.each do |tag|
    json.(tag, :id, :name)
    json.color tag.color.code
  end
end
