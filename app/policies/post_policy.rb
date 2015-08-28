class PostPolicy < ApplicationPolicy

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
    true
  end

  def destroy?
    true
    # user.present? && user.admin?
  end

end
