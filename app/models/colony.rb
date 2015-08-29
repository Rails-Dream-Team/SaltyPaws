class Colony < ActiveRecord::Base
  acts_as_paranoid

  has_many :colony_users
  has_many :users, through: :colony_users
  has_many :cats

  validates :name, :street_address, :city, :state, presence: true
  validates :pop, numericality: true, allow_nil: true

  def owners
    self.colony_users.where(owner: true).map do |o|
      o.user
    end
  end

  def volunteers
    self.colony_users.where(volunteer: true).map do |v|
      v.user
    end
  end
end
