class User < ActiveRecord::Base
  has_many :apps
  has_many :servers
  has_many :deploys

  ROLES = %w[admin moderator author banned]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable


  def password_required?
    super if confirmed?
  end

end
