class CreateRecoveries < ActiveRecord::Migration[7.0]
  def change
    create_table :recoveries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :code
      t.timestamp :valid_until

      t.timestamps
    end
  end
end
