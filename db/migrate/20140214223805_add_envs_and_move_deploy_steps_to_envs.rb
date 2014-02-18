class AddEnvsAndMoveDeployStepsToEnvs < ActiveRecord::Migration
  def up

    App.all.each do |app|
      env = Environment.new(name: :testing)
      env.app = app
      app.servers.each do |server|
        env.servers << server
      end
      env.save

      app.deploy_steps.each do |deploy_step|
        deploy_step.environment = env
        deploy_step.save
      end
    end

  end
end
