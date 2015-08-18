class Colony < ActiveRecord::Base
  has_many :colony_users
  has_many :users, through: :colony_users

  validates :name, :street_address, :city, :state, presence: true
  validates :pop, numericality: true, allow_nil: true
end
