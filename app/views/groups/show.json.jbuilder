json.id @group.id
json.members do
  json.partial! 'groups/members', members: @group.members
end
