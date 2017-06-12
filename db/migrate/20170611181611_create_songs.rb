class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :author
      t.string :tone

      t.timestamps
    end
  end
end
