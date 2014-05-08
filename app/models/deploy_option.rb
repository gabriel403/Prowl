class DeployOption < ActiveRecord::Base
  belongs_to :deploy_option_type
  belongs_to :deploy
  validates  :deploy_option_type, presence: true
  validates  :deploy,             presence: true
  validates  :value,              presence: true
end
