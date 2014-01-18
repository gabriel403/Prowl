class DeployOption < ActiveRecord::Base
  belongs_to :deploy_option_type
  belongs_to :deploy
end
