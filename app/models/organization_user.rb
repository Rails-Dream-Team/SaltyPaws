class OrganizationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  def user
  User.unscoped { super }
  end

  def organization
  Organization.unscoped { super }
  end

end
