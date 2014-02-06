module Remoteserver
  class Git
    require 'rye'

    def initialize()
      Rye::Cmd.add_command :git_fetch, '/usr/bin/git fetch --all'
      Rye::Cmd.add_command :git_reset, '/usr/bin/git reset --hard origin/master'
    end

    def deploy(app, server, deploy_options, file_operations, force = false)
      auth_type = server.authentication_type

      if auth_type.short_name == 'keystored'
        keys = [server.authentication]
        rbox = Rye::Box.new(server.host, :user => server.username, :key_data => keys, :keys_only => true)
      else
        raise "Invalid Authentication Type"
      end

      rbox[deploy_options.destination]

      success = false

      begin
        if force
          # rbox.git_fetch
          rbox.git_reset
        end

        result = rbox.git('pull')
        success = true
      rescue Exception => e
        result = e.to_s
      end

      return success, result
    end

  end
end