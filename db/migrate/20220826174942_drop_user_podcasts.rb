class DropUserPodcasts < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_podcasts
  end
end
