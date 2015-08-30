ActiveAdmin.register Colony do
  permit_params [
    :name,
    :photo,
    :street_address,
    :city,
    :state,
    :zip_code,
    :enviroment,
    :pop,
    :vet
  ]

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
