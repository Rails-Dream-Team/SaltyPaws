class Report
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :first_name, :last_name, :email, :phone, :street_address, :city, :state, :zip_code, :location, :pop, :fixed, :young, :current_caretaker

  validates :first_name, :email, :location, presence: true
end
