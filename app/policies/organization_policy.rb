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
    user.present? && user.volunteer? || user.present? && user.admin?
  end

  def destroy?
    user.present? && user.admin?
  end

end
