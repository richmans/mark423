class AddRenderingToPodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :rendering, :timestamp
    add_column :podcasts, :rendered, :timestamp
  end
end
