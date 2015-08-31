class ColonyPolicy < ApplicationPolicy

  def index?
    user.present? && user.volunteer? || user.present? && user.admin?
  end

  def new?
    user.present? && user.admin?
  end
  
  def create?
    true
  end

  def show?
    user.present? && user.volunteer? || user.present? && user.admin?
  end

  def update?
    user.present? && user.admin?
  end

  def destroy?
    user.present? && user.admin?
  end

end
