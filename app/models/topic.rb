class Topic < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :board
  has_many :posts, inverse_of: :topic
  accepts_nested_attributes_for :posts

  def user
    User.unscoped { super }
  end

  def board
    Board.unscoped { super }
  end

  validates :title, :user_id, :board_id, presence: true
end
