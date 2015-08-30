class ChangeRoleColumnDefaultUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :role, "basic"
  end
end
