ActiveAdmin.register User do
  scope :admin
  scope :volunteer
  scope :basic

index do
  column :id
  column :email
  column :first_name
  column :last_name
  column :display_name
  column :deleted_at
  column :role
  actions
end


end
