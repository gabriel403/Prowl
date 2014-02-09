module Remoteserver
  class Svn
    require 'rye'

    def add_commands(username, password, repo_address, rev_num, dest_dir)
      @svn_up     = "update --username #{username} --no-auth-cache --password #{password}"
      @svn_co     = "co --username #{username} --password #{password} --no-auth-cache #{repo_address}@#{rev_num} #{rev_num}"
      @svn_export = "export --username #{username} --password #{password} --no-auth-cache #{repo_address}@#{rev_num} #{dest_dir}/#{rev_num}"
      Rye::Cmd.add_command :svn_up, "/usr/bin/svn #{@svn_up}"
      Rye::Cmd.add_command :svn_co, "/usr/bin/svn #{@svn_co}"
      Rye::Cmd.add_command :svn_export, "/usr/bin/svn #{@svn_export}"
    end

    def deploy(app, server, deploy_options, file_operations)
      begin

        rbox            = file_operations.setup(server)
        success         = false
        outputs         = []

        output = rbox.mkdir :p, "#{deploy_options.destination}/#{deploy_options.rev_num}"
        Rails.logger.debug output
        outputs << output

        rbox[deploy_options.destination]

        if deploy_options.local_remote.deploy_step_type_option.name == "local"
          Rails.logger.debug "going for a local deploy and transfer"
          if deploy_options.checkout_export_update.deploy_step_type_option.name == "update_pull"
            # svn up
          elsif deploy_options.checkout_export_update.deploy_step_type_option.name == "checkout_clone"
            # svn co
          else
            # svn export
            Rails.logger.debug "going for a local export"

            export_dir = "/tmp/prowl/#{app.id}_#{app.deploys.last.id}"
            add_commands(deploy_options.vcs_username, deploy_options.vcs_password, deploy_options.vcs_location, deploy_options.rev_num, export_dir)

            output = Rye.shell :mkdir, :p, export_dir
            Rails.logger.debug output
            outputs << output

            output = Rye.shell :svn, @svn_export
            Rails.logger.debug output
            outputs << output

            output = rbox.dir_upload "#{export_dir}/#{deploy_options.rev_num}", "#{deploy_options.destination}"
            Rails.logger.debug output
            outputs << output

            output = Rye.shell :rm, :r, :f, "#{export_dir}"
            Rails.logger.debug output
            outputs << output

            if deploy_options.deployed_symlink
              output = rbox.ln :s, :f, :n, "#{deploy_options.destination}/#{deploy_options.rev_num}", "#{deploy_options.deployed_symlink.value}"
              Rails.logger.debug output
              outputs << output
            end

            output = file_operations.pre_do_chmod rbox, deploy_options.destination, deploy_options.rev_num
            Rails.logger.debug output
            outputs << output

            output = file_operations.process_deploy_options rbox, deploy_options, server
            Rails.logger.debug output
            outputs << output

            result = outputs.join("\r\n")
          end
        else
          Rails.logger.debug "going for a remote deploy"
          if deploy_options.checkout_export_update.deploy_step_type_option.name == "update_pull"
            # svn up
          elsif deploy_options.checkout_export_update.deploy_step_type_option.name == "checkout_clone"
            # svn co
          else
            # svn export
            Rails.logger.debug "going for a remote export"
            result = rbox.svn_export
          end
        end

        success = true
      rescue Exception => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.inspect
        result = e.to_s
      end

      return success, result
    end

  end
end