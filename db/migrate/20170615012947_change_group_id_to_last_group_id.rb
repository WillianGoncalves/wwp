class ChangeGroupIdToLastGroupId < ActiveRecord::Migration[5.0]
  def change
    remove_reference :users, :group, index: true
    add_column :users, :last_group_id, :integer
    add_foreign_key :users, :groups, column: :last_group_id, index: true
  end
end
