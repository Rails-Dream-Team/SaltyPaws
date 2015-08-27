class Organization < ActiveRecord::Base
  acts_as_paranoid
  
  has_many :organization_users
  has_many :users, through: :organization_users

  validates :name, presence: true

  def location
    if city && state
      self.city + ", " + self.state
    else
      'Location Unknown'
    end
  end
end
