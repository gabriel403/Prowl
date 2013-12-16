module Remoteserver
  class Git
    require 'rye'

    def initialize()
      Rye::Cmd.add_command :git_fetch, '/usr/bin/git fetch --all'
      Rye::Cmd.add_command :git_reset, '/usr/bin/git reset --hard origin/master'
    end

    def deploy(force = false)
      rbox = Rye::Box.new("127.0.0.1", :user => "wheeljack", :keys_only => true, :keys => ['/code/Wheeljack/puppet/modules/users/files/wheeljack/id_rsa'])
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