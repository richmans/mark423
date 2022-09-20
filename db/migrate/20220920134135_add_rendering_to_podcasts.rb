class AddRenderingToPodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :rendering, :timestamp, default: 0
    add_column :podcasts, :rendered, :timestamp, default: 0
  end
end
