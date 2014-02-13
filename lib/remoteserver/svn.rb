module Remoteserver
  class Svn
    require 'rye'

    def add_commands(username, password, repo_address, rev_num, dest_dir)
      @svn_up     = "update --username #{username} --no-auth-cache --password #{password}"
      @svn_co     = "co --username #{username} --password #{password} --no-auth-cache #{repo_address}@#{rev_num} #{dest_dir}/#{rev_num}"
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
            # probably the same steps as else except we co
            Rails.logger.debug "going for a local co"

            file_operations.upload_operations(rbox, deploy_options, server, app)
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

            Rails.logger.debug output

            output = Rye.shell :rm, :r, :f, "#{export_dir}"

              outputs << output

            Rails.logger.debug output

            output = file_operations.process_deploy_options rbox, deploy_options, server
            output = file_operations.upload_operations(rbox, deploy_options, server, app)
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

    def self.get_rev_nums(app)
      vcs_location = app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_location"}.value
      vcs_username = app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_username"}.value
      vcs_password = app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_value"}.value
      vcs_conn_str = "svn log --username #{vcs_username} --password #{vcs_password} --limit 10 --no-auth-cache #{vcs_location}"
      rev_nums = []
      revnums = `#{vcs_conn_str}`
      revnums.split("\n").each {|ele| 
        rev_num = /r(?<rev_num>\d+)/.match(ele) 
        if rev_num
          rev_nums << rev_num[:rev_num]
        end
      }
      return rev_nums
    end

  end
end