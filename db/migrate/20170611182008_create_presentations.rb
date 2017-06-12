class CreatePresentations < ActiveRecord::Migration[5.0]
  def change
    create_table :presentations do |t|
      t.date :date
      t.time :time
      t.string :local

      t.timestamps
    end
  end
end
