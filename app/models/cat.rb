class Cat < ActiveRecord::Base
  belongs_to :colony

  def colony
  Colony.unscoped { super }
  end

  validates :age, numericality: true, allow_nil: true
end
