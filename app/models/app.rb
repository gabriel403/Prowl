class App < ActiveRecord::Base
  has_many :deploys
  has_many :deploy_steps
  has_and_belongs_to_many :servers
  has_and_belongs_to_many :environments
  belongs_to :user
end
