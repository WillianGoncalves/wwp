class AddGroupToPresentation < ActiveRecord::Migration[5.0]
  def change
    add_reference :presentations, :group, foreign_key: true
  end
end
