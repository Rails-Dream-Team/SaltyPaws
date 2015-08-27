class Board < ActiveRecord::Base
  acts_as_paranoid

  has_many :topics

  validates :title, presence: true
end
