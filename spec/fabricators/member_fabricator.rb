Fabricator(:member) do
  admin false
end

Fabricator(:member_admin, from: :member) do
  admin true
end
