ActiveAdmin.register User do
  permit_params User.column_names

  scope :admin
  scope :volunteer
  scope :basic
  scope :all

  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :display_name
    column :deleted_at
    column :role
    column 'Site Admin?', :admin
    actions
  end

end
