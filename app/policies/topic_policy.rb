class TopicPolicy < ApplicationPolicy

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
    user.present? && user == topic.user
  end

  def destroy?
    user.present? && user.admin?
  end

  private

  def topic
    record
  end

end
