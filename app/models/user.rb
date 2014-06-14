class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  and :omniauthable
  before_save :ensure_authentication_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable

  has_many :organisation_users
  has_many :organisations, through: :organisation_users
  has_many :apps, through: :organisations
  has_many :env_users
  has_many :envs, through: :env_users
  has_many :servers, through: :envs

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
