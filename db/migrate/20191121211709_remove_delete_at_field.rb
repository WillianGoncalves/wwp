class RemoveDeleteAtField < ActiveRecord::Migration[5.2]
  def change
    remove_index :songs, :deleted_at
    remove_index :presentations, :deleted_at
    remove_column :songs, :deleted_at
    remove_column :presentations, :deleted_at
  end
end
