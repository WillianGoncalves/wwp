module Helpers
  def assign_group(user, group)
    user.last_group = group
    user.save
  end
end
