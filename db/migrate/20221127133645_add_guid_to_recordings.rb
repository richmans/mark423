class AddGuidToRecordings < ActiveRecord::Migration[7.0]
  def change
    add_column :recordings, :guid, :string
  end
end
