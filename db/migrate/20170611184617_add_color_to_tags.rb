class AddColorToTags < ActiveRecord::Migration[5.0]
  def change
    add_reference :tags, :color
  end
end
