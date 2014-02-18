module Tasks
  class Deployment
    require 'resque'

    @queue = :file_serve

    def self.perform(env_id, server_id, deploy_id, force = false)
      env             = Environment.find(env_id)
      server          = Server.find(server_id)
      deploy          = Deploy.find(deploy_id)

      file_operations = Remoteserver::FileOperations.new
      deploy_options  = Remoteserver::DeployOptions.new(env)

      deploy.update_attributes(:status => 'processing')

      if deploy_options.hooks
        Remoteserver::DeployHooks.send_update deploy, :processing
      end

      case env.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_type"}.deploy_step_type_option.name
      when 'svn'
        rs = Remoteserver::Svn.new
      when 'git'
        rs = Remoteserver::Git.new
      end

      @success, @returnval = rs.deploy(env, server, deploy_options, file_operations, true)

      if @success
        if deploy_options.hooks
          Remoteserver::DeployHooks.send_update deploy, :finished
        end
      else
        if deploy_options.hooks
          Remoteserver::DeployHooks.send_update deploy, :failed
        end
      end

      deploy.update_attributes(:status => (@success ? 'finished' : 'failed'), :output => @returnval.to_s)
    end
  end
end

