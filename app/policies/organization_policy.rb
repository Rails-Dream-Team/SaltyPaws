class OrganizationPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user.volunteer? || user.admin?
  end

  def destroy?
    user.admin?
  end

end
