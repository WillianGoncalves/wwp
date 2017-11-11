class AddDeletedAtToPresentations < ActiveRecord::Migration[5.1]
  def change
    add_column :presentations, :deleted_at, :datetime
    add_index :presentations, :deleted_at
  end
end
