module Tasks
  class Deploy
    require 'resque'
    require_dependency "remoteserver/git"

    @queue = :file_serve

    def self.perform(app_id, server_id, deploy_id, force = false)
      Resque.logger = Logglier.new("https://logs-01.loggly.com/inputs/bd5fce10-4fba-4433-8b89-ebe68a5c270e/tag/ruby/")
      deploy.update_attributes(:status => :Processing)

      git = Remoteserver::Git.new

      app    = App.find(app_id)
      server = Server.find(server_id)
      deploy = Deploy.find(deploy_id)

      @success, @returnval = git.deploy(app, server, deploy, force)

      deploy.update_attributes(:status => (@success ? :Finished : :Failed), :output => @returnval.to_s)
    end
  end
end

