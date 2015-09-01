class BoardPolicy < ApplicationPolicy

  def new?
    user ? user.admin? : false
  end

  def create?
    user.admin?
  end

  def show?
    user || record.public
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

end
