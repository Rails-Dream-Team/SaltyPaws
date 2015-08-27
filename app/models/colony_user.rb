class ColonyUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :colony

  def user
  User.unscoped { super }
  end

  def colony
    Colony.unscoped { super }
  end

end
