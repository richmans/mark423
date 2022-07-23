class CreatePodcasts < ActiveRecord::Migration[7.0]
  def change
    create_table :podcasts do |t|
      t.string :name
      t.string :shortname
      t.string :copyright
      t.string :author
      t.string :email
      t.string :keywords

      t.timestamps
    end
  end
end
