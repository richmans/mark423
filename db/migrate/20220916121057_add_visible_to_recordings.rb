class AddVisibleToRecordings < ActiveRecord::Migration[7.0]
  def change
    add_column :recordings, :visible, :boolean
  end
end
