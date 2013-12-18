module Remoteserver
  class Git
    require 'rye'

    def initialize()
      Rye::Cmd.add_command :git_fetch, '/usr/bin/git fetch --all'
      Rye::Cmd.add_command :git_reset, '/usr/bin/git reset --hard origin/master'
    end

    def deploy(app, server, force = false)
      auth_type = AuthenticationType.find(server.authentication_type)

      if auth_type.short_name == 'storedkey'
        keys = [server.authentication]
        rbox = Rye::Box.new(server.host, :user => server.username, :key_data => keys, :keys_only => true)
      end

      rbox['/usr/local/apps/prowl']

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