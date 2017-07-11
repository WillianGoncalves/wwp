class RenameInviteToJoinRequest < ActiveRecord::Migration[5.0]
  def change
    rename_table 'invites', 'join_requests'
  end
end
