class RemoveAppIdFromDeploySteps < ActiveRecord::Migration
  def change
    remove_column :deploy_steps, :app_id, :int
  end
end
