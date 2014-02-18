class App < ActiveRecord::Base
  has_many :environments
  belongs_to :user
end
