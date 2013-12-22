module Tasks
  class Deployment
    require 'resque'
    require_dependency "remoteserver/git"

    @queue = :file_serve

    def self.perform(app_id, server_id, deploy_id, force = false)
      Resque.logger = Logglier.new("https://logs-01.loggly.com/inputs/bd5fce10-4fba-4433-8b89-ebe68a5c270e/tag/ruby/")

      git = Remoteserver::Git.new

      app    = App.find(app_id)
      server = Server.find(server_id)
      deploy = Deploy.find(deploy_id)

      deploy.update_attributes(:status => 'Processing')

      @success, @returnval = git.deploy(app, server, force)

      deploy.update_attributes(:status => (@success ? 'Finished' : 'Failed'), :output => @returnval.to_s)
    end
  end
end

