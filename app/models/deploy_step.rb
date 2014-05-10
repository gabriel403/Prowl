class DeployStep < ActiveRecord::Base
  belongs_to :env
  belongs_to :deploy_step_type_option
  validates :env,                     presence: true
  validates :deploy_step_type_option, presence: true
end
