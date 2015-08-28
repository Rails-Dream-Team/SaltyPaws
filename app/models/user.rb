require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base
  acts_as_paranoid

  has_many :colony_users
  has_many :colonies, through: :colony_users
  has_many :organization_users
  has_many :organizations, through: :organization_users
  has_many :topics
  has_many :posts

  def admin?
    role == "admin"
  end

  def volunteer?
    role == "volunteer"
  end

  def basic?
    role == "basic"
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :timeoutable, :validatable

  validates :first_name, :last_name, :display_name, :email, presence: true
  validates :age, numericality: true, allow_nil: true

  mount_uploader :avatar, AvatarUploader
  def avatar=(obj)
    super(obj)
  end

end
