class Post < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :topic, inverse_of: :posts
  belongs_to :user

  def user
    User.unscoped { super }
  end

  def topic
    Topic.unscoped { super }
  end

  validates :content, :user_id, presence: true
  validates :topic_id, presence: true, on: :update

  before_validation :set_user_id, if: -> { user_id.nil? }

  private

  def set_user_id
    self.user_id = topic.user_id
  end
end
