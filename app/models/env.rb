class Env < ActiveRecord::Base
  belongs_to :app
  has_many   :deploys
  has_many   :env_users
  has_many   :users, through: :env_users
  has_many   :env_servers
  has_many   :servers, through: :env_servers
  validates  :app,  presence: true
  validates  :name, presence: true
end
