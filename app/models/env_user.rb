class EnvUser < ActiveRecord::Base
  belongs_to :env
  belongs_to :user
  belongs_to :access_level
  validates  :env,           presence: true
  validates  :user,          presence: true
  validates  :access_level,  presence: true
  validates  :user, uniqueness: { scope: :env }

  validate   :env_must_belong_to_the_same_organisation_as_user

  def env_must_belong_to_the_same_organisation_as_user
    if !env || !user
      return
    end
    unless env.app.organisation == user.organisations.first
      errors.add(:base, "User's and env's organisations mismatch!")
    end
  end
end
