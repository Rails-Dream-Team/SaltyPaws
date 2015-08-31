class BoardPolicy < ApplicationPolicy

  def index?
    true
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    true
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

end
