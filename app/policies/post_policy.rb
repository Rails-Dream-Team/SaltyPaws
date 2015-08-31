class PostPolicy < ApplicationPolicy

  def index?
    user
  end

  def show?
    user || record.topic.board.public
  end

  def edit?
    user.admin? ? true : user == record.user
  end

  def update?
    user.admin? ? true : user == record.user
  end

  def destroy?
    user.admin?

    # If allowing user to delete topics they created, use this instead
    # user.admin? ? true : user == topic.user
  end

end
