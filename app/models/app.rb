class App < ActiveRecord::Base
  has_many :deploys
  has_and_belongs_to_many :servers
  belongs_to :user
end
