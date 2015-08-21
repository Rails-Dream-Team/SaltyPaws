class Volunteer
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :first_name, :last_name, :email, :phone,
  :age, :vol_areas, :skills, :availability

  validates :first_name, :last_name, :email, presence: true
end
