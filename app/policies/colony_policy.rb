class ColonyPolicy < ApplicationPolicy

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
    return true if user.present? && user.admin?

    user.present? && user == colony.owners
  end

  def destroy?
    user.present? && user.admin?
  end

  private

  def colony
    record
  end

end
