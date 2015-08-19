class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :instagram, :string
    add_column :users, :about_me, :text
    add_column :users, :pets, :string
    add_column :users, :volunteer_work, :text
  end
end
