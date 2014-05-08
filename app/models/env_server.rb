class EnvServer < ActiveRecord::Base
  belongs_to :env
  belongs_to :server
  validates  :env,    presence: true
  validates  :server, presence: true
  validates  :server, uniqueness: { scope: :env }

  validate   :env_must_belong_to_the_same_organisation_as_server

  def env_must_belong_to_the_same_organisation_as_server
    if !env || !server
      return
    end
    unless env.app.organisation == server.organisation
      errors.add(:base, "User's and env's organisations mismatch!")
    end
  end
end
