class CreateColonyUsers < ActiveRecord::Migration
  def change
    create_table :colony_users do |t|
      t.integer :user_id
      t.integer :colony_id
      t.boolean :owner
      t.boolean :volunteer
      t.boolean :care_taker

      t.timestamps null: false
    end
    add_index :colony_users, [:user_id, :colony_id], unique: true
  end
end
