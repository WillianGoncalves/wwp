class ChangeColumnNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null(:comments, :target_id, false)
    change_column_null(:comments, :target_type, false)
    change_column_null(:comments, :user_id, false)
    change_column_null(:invites, :user_id, false)
    change_column_null(:invites, :group_id, false)
    change_column_null(:members, :user_id, false)
    change_column_null(:members, :group_id, false)
    change_column_null(:presentations, :group_id, false)
    change_column_null(:songs, :group_id, false)
    change_column_null(:tags, :color_id, false)
  end
end
