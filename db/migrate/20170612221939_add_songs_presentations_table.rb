class AddSongsPresentationsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :presentations_songs, id: false do |t|
      t.belongs_to :song, index: true
      t.belongs_to :presentation, index: true
    end
  end
end
