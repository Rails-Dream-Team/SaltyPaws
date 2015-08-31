class ColonyPolicy < ApplicationPolicy

  def index?
    user.volunteer? || user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    user.volunteer? || user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

end
