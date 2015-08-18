class ColonyUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :colony
end
