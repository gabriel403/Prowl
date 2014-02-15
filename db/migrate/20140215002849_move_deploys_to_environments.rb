class MoveDeploysToEnvironments < ActiveRecord::Migration
  def up
    App.all.each do |app|
      env = app.environments.first
      app.deploys.each do |deploy|
        deploy.environment = env
        deploy.save
      end
    end
  end
end
