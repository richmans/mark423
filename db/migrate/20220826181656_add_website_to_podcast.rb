class AddWebsiteToPodcast < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :website, :string
  end
end
