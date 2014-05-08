class Env < ActiveRecord::Base
  belongs_to :app
  has_many   :deploys
  has_many   :env_users
  validates  :app,  presence: true
  validates  :name, presence: true
end
