class BoardPolicy < ApplicationPolicy

  def index?
    true
  end

  def new?
    user.present? && user.admin?
  end
  
  def create?
    user.present? && user.admin?
  end

  def show?
    true
  end

  def update?
    user.present? && user.admin?
  end

  def destroy?
    user.present? && user.admin?
  end

end
