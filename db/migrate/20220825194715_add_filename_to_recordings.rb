class AddFilenameToRecordings < ActiveRecord::Migration[7.0]
  def change
    add_column :recordings, :filename, :string
  end
end
