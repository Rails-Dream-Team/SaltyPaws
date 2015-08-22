class Volunteer
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :first_name, :last_name, :email, :phone, :age, :adoption_events, :transportation, :assist_with_trapping, :colony_caregiver, :substitute_colony_caregiver, :skills, :weekends, :weekdays, :evenings, :daytime, :flexible

  validates :first_name, :last_name, :email, presence: true
end
