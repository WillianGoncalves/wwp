class AddGroupToSongs < ActiveRecord::Migration[5.0]
  def change
    add_reference :songs, :group, foreign_key: true
  end
end
