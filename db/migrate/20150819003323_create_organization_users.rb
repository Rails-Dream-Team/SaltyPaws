class CreateOrganizationUsers < ActiveRecord::Migration
  def change
    create_table :organization_users do |t|
      t.integer :user_id
      t.integer :organization_id
      t.boolean :admin

      t.timestamps null: false
    end
    add_index :organization_users, [:user_id, :organization_id], unique: true
  end
end
