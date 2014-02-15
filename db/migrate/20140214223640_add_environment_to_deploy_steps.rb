class AddEnvironmentToDeploySteps < ActiveRecord::Migration
  def change
    add_reference :deploy_steps, :environment, index: true
  end
end
