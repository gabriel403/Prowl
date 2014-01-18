module Tasks
  class Deployment
    require 'resque'
    require_dependency "remoteserver/git"

    @queue = :file_serve

    def self.perform(app_id, server_id, deploy_id, force = false)
      Resque.logger = Le.new('5c703294-66e8-45db-aeba-1e8915b4c20c')

      app    = App.find(app_id)
      server = Server.find(server_id)
      deploy = Deploy.find(deploy_id)

      deploy.update_attributes(:status => 'Processing')

      case app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_type"}.deploy_step_type_option.name
      when 'svn'
        rs = Remoteserver::Svn.new
      when 'git'
        rs = Remoteserver::Git.new
      end

      @success, @returnval = rs.deploy(app, server, force)

      deploy.update_attributes(:status => (@success ? 'Finished' : 'Failed'), :output => @returnval.to_s)
    end
  end
end

