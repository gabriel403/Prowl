class App < ActiveRecord::Base
  has_many :deploys
  belongs_to :user
end
