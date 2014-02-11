class Server < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :apps
  has_and_belongs_to_many :environments
  belongs_to :authentication_type
  has_many :deploys
end
