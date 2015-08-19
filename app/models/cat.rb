class Cat < ActiveRecord::Base
  belongs_to :colony

  validates :age, numericality: true, allow_nil: true
end
