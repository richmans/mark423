class CreatePrivileges < ActiveRecord::Migration[7.0]
  def change
    create_table :privileges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :podcast, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
