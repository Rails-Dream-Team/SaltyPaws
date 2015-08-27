class ColonyUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :colony

  def user
  User.unscoped { super }
  end
  
end
