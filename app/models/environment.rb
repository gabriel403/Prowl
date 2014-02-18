class Environment < ActiveRecord::Base
  belongs_to :app
  has_and_belongs_to_many :servers
  has_many :deploy_steps
  has_many :deploys
end
