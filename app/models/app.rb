class App < ActiveRecord::Base
  has_many :deploys
  has_many :deploy_steps
  has_many :environments
  has_and_belongs_to_many :servers
  belongs_to :user
end
