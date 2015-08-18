class Colony < ActiveRecord::Base
  validates :name, :street_address, :city, :state, presence: true
  validates :pop, numericality: true, allow_nil: true
end
