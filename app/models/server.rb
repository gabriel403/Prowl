class Server < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :apps
  belongs_to :authentication_type
end
