module GroupsHelper
  def can_remove_member?(member)
    current_user.is_admin_of?(current_group) && current_user != member.user
  end
end
