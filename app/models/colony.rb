class Colony < ActiveRecord::Base
  acts_as_paranoid
  
  has_many :colony_users
  has_many :users, through: :colony_users
  has_many :cats

  validates :name, :street_address, :city, :state, presence: true
  validates :pop, numericality: true, allow_nil: true
end
