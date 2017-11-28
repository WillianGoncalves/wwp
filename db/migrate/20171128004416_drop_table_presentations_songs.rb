class DropTablePresentationsSongs < ActiveRecord::Migration[5.1]
  def change
    drop_table :presentations_songs
  end
end
