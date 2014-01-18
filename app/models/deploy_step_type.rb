class DeployStepType < ActiveRecord::Base
  has_many :deploy_step_type_options
end
