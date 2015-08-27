class OrganizationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  def user
  User.unscoped { super }
  end
  
end
