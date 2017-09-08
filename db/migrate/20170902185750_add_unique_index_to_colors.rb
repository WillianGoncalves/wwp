class AddUniqueIndexToColors < ActiveRecord::Migration[5.1]
  def change
    add_index(:colors, :name, unique: true)
    add_index(:colors, :code, unique: true)
  end
end
