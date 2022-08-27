class AddExplicitToPodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :explicit, :boolean
  end
end
