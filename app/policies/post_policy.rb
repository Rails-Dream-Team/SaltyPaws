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
    return true if user.present? && user.admin?

    user.present? && user == post.user
  end

  def destroy?
    return true if user.present? && user.admin?

    user.present? && user == post.user
  end

  private

  def post
    record
  end

end
