class AddGroupsToTags < ActiveRecord::Migration[5.1]
  def change
    add_reference :tags, :group, foreign_key: true
  end
end
