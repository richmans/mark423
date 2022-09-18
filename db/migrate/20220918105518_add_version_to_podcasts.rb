class AddVersionToPodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :version, :integer, default: 0
    add_column :podcasts, :rendered_version, :integer, default: 0
    add_column :podcasts, :rendering_version, :integer, default: 0
  end
end
