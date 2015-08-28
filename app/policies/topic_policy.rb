class TopicPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?

  end

  def show?

  end

  def update?

  end

  def destroy?
    user.present? && user.admin?
  end
end
