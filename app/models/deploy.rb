class Deploy < ActiveRecord::Base
  belongs_to :server
  belongs_to :env
  belongs_to :user
  validates :server, presence: true
  validates :env,    presence: true
  validates :user,   presence: true

  validate :env_must_belong_to_the_same_organisation_as_user
  validate :server_must_belong_to_the_same_organisation_as_user

  def env_must_belong_to_the_same_organisation_as_user
    if !env || !user
      return
    end
    unless env.app.organisation == user.organisations.first
      errors.add(:base, "User's and env's organisations mismatch!")
    end
  end

  def server_must_belong_to_the_same_organisation_as_user
    if !server || !user
      return
    end
    unless server.organisation == user.organisations.first
      errors.add(:base, "User's and server's organisations mismatch!")
    end
  end
end
