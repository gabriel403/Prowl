module Tasks
  class Deployment
    require 'resque'

    @queue = :file_serve

    def self.perform(app_id, server_id, deploy_id, force = false)
      app             = App.find(app_id)
      server          = Server.find(server_id)
      deploy          = Deploy.find(deploy_id)

      file_operations = Remoteserver::FileOperations.new
      deploy_options  = Remoteserver::DeployOptions.new(app)

      deploy.update_attributes(:status => 'processing')

      if deploy_options.hooks
        Remoteserver::DeployHooks.send_update deploy_options.hooks, deploy, :processing
      end

      case app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_type"}.deploy_step_type_option.name
      when 'svn'
        rs = Remoteserver::Svn.new
      when 'git'
        rs = Remoteserver::Git.new
      end

      @success, @returnval = rs.deploy(app, server, deploy_options, file_operations)

      if @success
        if deploy_options.hooks
          Remoteserver::DeployHooks.send_update deploy_options.hooks, deploy, :finished
        end
      else
        if deploy_options.hooks
          Remoteserver::DeployHooks.send_update deploy_options.hooks, deploy, :failed
        end
      end

      deploy.update_attributes(:status => (@success ? 'finished' : 'failed'), :output => @returnval.to_s)
    end
  end
end

