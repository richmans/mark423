class AddDescriptionToPodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :description, :text
  end
end
