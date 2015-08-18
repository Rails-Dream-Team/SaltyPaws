class ChangeDisplayNameToUserNameInUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :display_name, false
    add_index :users, :display_name
  end
end
