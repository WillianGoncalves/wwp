class AddDatetimeToPresentation < ActiveRecord::Migration[5.1]
  def change
    remove_column :presentations, :date
    remove_column :presentations, :time
    add_column :presentations, :date_time, :datetime
  end
end
