class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :board
  has_many :posts

  validates :title, :user_id, :board_id, presence: true
end
