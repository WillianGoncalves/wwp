class AddTargetToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :target, polymorphic: true
  end
end
