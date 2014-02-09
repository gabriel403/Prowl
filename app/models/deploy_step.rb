class DeployStep < ActiveRecord::Base
  default_scope { order('"order" ASC') }
  serialize :additional, JSON
  belongs_to :deploy_step_type_option
  belongs_to :app
end
