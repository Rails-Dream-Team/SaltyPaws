class DropAdminUsersTable < ActiveRecord::Migration
  def change
    remove_index :admin_users, :email
    remove_index :admin_users, :reset_password_token
    drop_table :admin_users
  end
end
