class CreateRecordings < ActiveRecord::Migration[7.0]
  def change
    create_table :recordings do |t|
      t.references :podcast, null: false, foreign_key: true
      t.string :speaker
      t.string :theme
      t.timestamp :recorded_at
      t.boolean :published
      t.text :description

      t.timestamps
    end
  end
end
