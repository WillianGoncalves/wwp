json.(group, :id, :name)
json.members do
  json.partial! 'groups/members', members: group.members
end
