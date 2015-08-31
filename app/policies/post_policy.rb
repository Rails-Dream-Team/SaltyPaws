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
    user.present? && user == post.user
  end

  def destroy?
    user.present? && user.admin?
  end

  private

  def post
    record
  end

end
