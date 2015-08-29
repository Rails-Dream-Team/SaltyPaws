ActiveAdmin.register User do
  permit_params [
    :first_name,
    :last_name,
    :display_name,
    :email,
    :street_address,
    :city,
    :state,
    :zip,
    :phone,
    :age,
    :twitter,
    :facebook,
    :instagram,
    :about_me,
    :pets,
    :volunteer_work,
    :avatar,
    :role,
    :admin
  ]

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
