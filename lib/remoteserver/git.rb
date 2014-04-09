module Remoteserver
  class Git
    require 'rye'
    require 'git-ssh-wrapper'

    def add_commands(repo_address, rev_num, dest_dir)
      @git_clone     = "clone --recursive #{repo_address} #{dest_dir}/#{rev_num}"
      @git_checkout  = "checkout master~#{rev_num}"

      Rye::Cmd.add_command :git_fetch, '/usr/bin/git fetch --all'
      Rye::Cmd.add_command :git_reset, '/usr/bin/git reset --hard origin/master'
    end

    def deploy(env, server, deploy_options, file_operations, force = false)
      begin
        rbox            = file_operations.setup(server)
        success         = false
        @outputs         = []

        output = rbox.mkdir :p, "#{deploy_options.destination}/#{deploy_options.rev_num}"
        Rails.logger.debug output
        @outputs << output

        rbox[deploy_options.destination]

        if deploy_options.local_remote.deploy_step_type_option.name == "local"
          Rails.logger.debug "going for a local deploy and transfer"
          # git clone
          export_dir = "/tmp/prowl/#{env.id}_#{env.deploys.last.id}"
          add_commands(deploy_options.vcs_location, deploy_options.rev_num, export_dir)

          output = Rye.shell :mkdir, :p, export_dir
          Rails.logger.debug output
          @outputs << output

          @git_co_branch = "cd #{export_dir}/#{deploy_options.rev_num} && /usr/bin/git checkout #{deploy_options.branch_name}"
          GitSSHWrapper.with_wrapper(:private_key => deploy_options.vcs_password) do |wrapper|
            wrapper.set_env
            Rails.logger.debug @git_clone
            output = Rye.shell :git, @git_clone
            Rails.logger.debug output
            @outputs << output

            Rails.logger.debug @git_co_branch
            output = `#{@git_co_branch}`
            Rails.logger.debug output
            @outputs << output
          end

          output = file_operations.upload_operations(rbox, deploy_options, server, env)
          Rails.logger.debug output
          @outputs << output

          result = @outputs.join("\r\n")
        else
          Rails.logger.debug "going for a remote deploy"
          add_commands(deploy_options.vcs_location, deploy_options.rev_num, '/tmp/prowl')
          if force
            # rbox.git_fetch
            rbox.git_reset
          end

          result = rbox.git('pull')
          Rails.logger.debug result
          success = true
        end

        success = true
      rescue Exception => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.inspect
        result = e.to_s
      end


      return success, result
    end

    def self.get_branch_names(env)
      branch_names = []
      begin
        vcs_location = env.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "vcs_location"}
        vcs_location = vcs_location ? vcs_location.value : vcs_location

        vcs_password = env.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_value"}
        vcs_password = vcs_password ? vcs_password.value : vcs_password

        if !vcs_location || !vcs_password
          branch_names << 'master'
          return branch_names
        end

        @revnums     = ''
        vcs_conn_str = "git ls-remote --heads #{vcs_location} | sed -E 's?(.+)[[:space:]]+refs/heads/(.+)?\\1 \\2?'"
        GitSSHWrapper.with_wrapper(:private_key => vcs_password) do |wrapper|
          wrapper.set_env
          @revnums = `#{vcs_conn_str}`
          Rails.logger.debug vcs_conn_str
          Rails.logger.debug @revnums
        end

        branch_names = @revnums.split( /\r?\n/ )
        Rails.logger.debug branch_names
      rescue Exception => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.inspect
        result = e.to_s
      end

      return branch_names
    end

    def self.get_rev_nums(env)
      rev_nums = []
      begin
        vcs_location = env.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "vcs_location"}
        vcs_location = vcs_location ? vcs_location.value : vcs_location

        vcs_password = env.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_value"}
        vcs_password = vcs_password ? vcs_password.value : vcs_password

        if !vcs_location || !vcs_password
          rev_nums << 'HEAD'
          return rev_nums
        end
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
        rev_nums << @revnums.tr("^a-zA-Z0-9 ", "")
        Rails.logger.debug rev_nums
      rescue Exception => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.inspect
        result = e.to_s
      end
      return rev_nums
    end
  end
end