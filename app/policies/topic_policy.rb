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

  def edit?
    return true if user.present? && user.admin?

    user.present? && user == topic.user
  end

  def update?
    return true if user.present? && user.admin?

    user.present? && user == topic.user
  end

  def destroy?
    return true if user.present? && user.admin?

    # Uncomment if allowing user to delete topics they created
    # user.present? && user == topic.user
  end

  private

  def topic
    record
  end

end
