module Remoteserver
  class Git
    require 'rye'
    require 'git-ssh-wrapper'

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

    def self.get_rev_nums(app)
      rev_nums = []
      begin
        vcs_location = vcs_location ? vcs_location.value : vcs_location
        vcs_password = app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_value"}
        vcs_password = vcs_password ? vcs_password.value : vcs_password

        # cred = Rugged::Credentials::SshKey.new username: 'jarvis', publickey: publickey, privatekey: privatekey
        # Rails.logger.debug cred
        # repo = Rugged::Repository.clone_at(vcs_location, export_dir, {:credentials => cred})
        # Rails.logger.debug repo


        # Rugged::Walker.new repo
        # git log -n 10 master --format=oneline

        @revnums = ''
        vcs_conn_str = "git ls-remote #{vcs_location} | grep refs/heads/master | cut -f 1"
        GitSSHWrapper.with_wrapper(:private_key => vcs_password) do |wrapper|
          wrapper.set_env
          @revnums = `#{vcs_conn_str}`
          Rails.logger.debug vcs_conn_str
          Rails.logger.debug `#{vcs_conn_str}`
        end
        Rails.logger.debug rev_nums
      rescue Exception => e
        Rails.logger.error e.backtrace.inspect
        result = e.to_s
      end
      return rev_nums
    end
  end
end