class Deploy < ActiveRecord::Base
  has_many :deploy_options
  belongs_to :app
  belongs_to :server
end
