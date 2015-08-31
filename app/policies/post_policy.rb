class PostPolicy < ApplicationPolicy

  def index?
    user
  end

  def create?
    user
  end

  def show?
    user
  end

  def edit?
    user.admin? ? true : user == topic.user
  end

  def update?
    user.admin? ? true : user == topic.user
  end

  def destroy?
    user.admin?

    # If allowing user to delete topics they created, use this instead
    # user.admin? ? true : user == topic.user
  end

  private

  def post
    record
  end

end
