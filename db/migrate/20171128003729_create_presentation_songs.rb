class CreatePresentationSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :presentation_songs do |t|
      t.references :presentation, foreign_key: true
      t.references :song, foreign_key: true
      t.integer :index

      t.timestamps
    end
  end
end
