class AddCategoryToPodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :category, :text
  end
end
