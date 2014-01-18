module Remoteserver
  class Svn
    require 'rye'

    def add_commands(username, password, repo_address, rev_num)
      Rye::Cmd.add_command :svn_up, "/usr/bin/svn update --username #{username} --no-auth-cache --password #{password}"
      Rye::Cmd.add_command :svn_co, "/usr/bin/svn co --username #{username} --password #{password} --no-auth-cache #{repo_address}@#{rev_num} #{rev_num}"
      Rye::Cmd.add_command :svn_export, "/usr/bin/svn export --username #{username} --password #{password} --no-auth-cache #{repo_address}@#{rev_num} #{rev_num}"
    end

    def deploy(app, server, force = false)
      auth_type = server.authentication_type

      if auth_type.short_name == 'keystored'
        keys = [server.authentication]
      else
        raise "Invalid Authentication Type"
      end

      destination             = app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "destination"}.value
      local_remote            = app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_location"}
      checkout_export_update  = app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_method"}

      deployed_symlink        = app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deployed_symlink"}

      svn_username            = app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_username"}.value
      svn_password            = app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_value"}.value
      svn_location            = app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "vcs_location"}.value

      fs_chs                  = app.deploy_steps.find_all {|ds| ds.deploy_step_type_option.deploy_step_type.name == "ch_dir"}

      has_sudo                = app.deploy_steps.find_all {|ds| ds.deploy_step_type_option.name == "has_sudo"}

      rev_num                 = app.deploys.last.deploy_options.find {|doe| doe.deploy_option_type.name == "revision_number"}.value

      add_commands(svn_username, svn_password, svn_location, rev_num)


      success = false

      begin
        outputs = []
        rbox = Rye::Box.new(server.host, :user => server.username, :key_data => keys, :keys_only => true)

        output = rbox.mkdir :p, "#{destination}/#{rev_num}"
        Resque.logger.debug output
        outputs << output

        rbox[destination]

        if local_remote.deploy_step_type_option.name == "local"
          Resque.logger.debug "going for a local deploy and transfer"
          if checkout_export_update.deploy_step_type_option.name == "update_pull"
            # svn up
          elsif checkout_export_update.deploy_step_type_option.name == "checkout_clone"
            # svn co
          else
            # svn export
            Resque.logger.debug "going for a local export"

            export_dir = "/tmp/prowl/#{app.id}_#{app.deploys.last.id}"
            output = Rye.shell :mkdir, :p, export_dir

            output = Rye.shell :svn, "export --username #{svn_username} --password #{svn_password} --no-auth-cache #{svn_location}@#{rev_num} #{export_dir}/#{rev_num}"
            Resque.logger.debug output
            outputs << output

            output = rbox.dir_upload "#{export_dir}/#{rev_num}", "#{destination}"
            Resque.logger.debug output
            outputs << output

            output = Rye.shell :rm, :r, :f, "#{export_dir}"
            Resque.logger.debug output
            outputs << output

            if deployed_symlink
              output = rbox.ln :s, :f, :n, "#{destination}/#{rev_num}", "#{deployed_symlink.value}"
              Resque.logger.debug output
              outputs << output
            end

            if fs_chs
              fs_chs.each do |fs_ch|
                if "chown_dir" == fs_ch.deploy_step_type_option.name && has_sudo
                  # error
                end

                if "chmod_dir" == fs_ch.deploy_step_type_option.name
                end
              end
            end

            result = outputs.join("\r\n")
          end
        else
          Resque.logger.debug "going for a remote deploy"
          if checkout_export_update.deploy_step_type_option.name == "update_pull"
            # svn up
          elsif checkout_export_update.deploy_step_type_option.name == "checkout_clone"
            # svn co
          else
            # svn export
            Resque.logger.debug "going for a remote export"
            result = rbox.svn_export
          end
        end

        # is remote or local?
        # if local do we start execing or ssh into ourself?
        # checkout or export
        # if local transfer files
        success = true
      rescue Exception => e
        Resque.logger.error e.message
        Resque.logger.error e.backtrace.inspect
        result = e.to_s
      end

      return success, result
    end

  end
end