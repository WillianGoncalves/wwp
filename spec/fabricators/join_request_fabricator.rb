Fabricator(:pending_join_request, from: :join_request) do
  user
  accepted nil
end

Fabricator(:accepted_join_request, from: :pending_join_request) do
  accepted true
  before_create do |join_request|
    join_request.group.add_member!(join_request.user)
  end
end

Fabricator(:refused_join_request, from: :pending_join_request) do
  accepted false
end
