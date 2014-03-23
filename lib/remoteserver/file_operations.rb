module Remoteserver
  class FileOperations

    def setup(server)
      if server.authentication_type.short_name == 'keystored'
        keys = [server.authentication]
      else
        raise "Invalid Authentication Type"
      end
      rbox = Rye::Box.new(server.host, :user => server.username, :key_data => keys, :keys_only => true)
      return rbox
    end

    def bundle_install(rbox, deploy_options)
      output = ''
      # bundle install --deployment
      return output
    end

    def db_migrate(rbox, deploy_options)
      output = ''
      # rake db:migrate# RAILS_ENV=development
      return output
    end

    def restart_web_server(rbox, deploy_options)
      output = ''
      return output
    end

    def set_sudo(rbox, server)
      output = ''
      if server.can_sudo
        rbox.mkdir :p, "/home/#{server.username}/bin"
        setAskPass = 'printf "#!/bin/bash\necho ' << Shellwords.escape(server.sudo_password).gsub("%","%%") << '\n" > /home/' << server.username << '/bin/supass'
        rbox.execute setAskPass
        rbox.setenv "SUDO_ASKPASS", "/home/#{server.username}/bin/supass"
        output = rbox.chmod '0700', "/home/#{server.username}/bin/supass"
      end
      return output
    end

    def rem_sudo(rbox, server)
      if server.can_sudo
        rbox.rm "/home/#{server.username}/bin/supass"
      end
    end

    def pre_do_chmod(rbox, destination, rev_num)
      rbox.disable_safe_mode
      rbox.execute "find #{destination}/#{rev_num} -type d -exec chmod 775 {} \\;"
      rbox.execute "find #{destination}/#{rev_num} -type f -exec chmod 664 {} \\;"
      rbox.enable_safe_mode
    end

    def process_deploy_options(rbox, deploy_options, server)
      outputs = []
      if deploy_options.fs_chs
        deploy_options.fs_chs.each do |fs_ch|
          if "chown_dir" == fs_ch.deploy_step_type_option.name && !server.can_sudo
            # error
          elsif "chown_dir" == fs_ch.deploy_step_type_option.name
            rbox.disable_safe_mode

            output = set_sudo rbox, server
            Resque.logger.debug output
            outputs << output

            owner_group = fs_ch.additional.has_key?("owner") ? fs_ch.additional['owner'] : ":#{fs_ch.additional['group']}"
            output = rbox.sudo :A, :chown, :R, owner_group, fs_ch.value
            Resque.logger.debug output
            outputs << output

            output = rem_sudo rbox, server
            Resque.logger.debug output
            outputs << output

            rbox.enable_safe_mode
          elsif "chmod_dir" == fs_ch.deploy_step_type_option.name
            output = rbox.chmod :R, fs_ch.additional['perms'], fs_ch.value
            Resque.logger.debug output
          end
        end
      end
      return outputs
    end



    def upload_operations(rbox, deploy_options, server, app)
      outputs = []

      export_dir = "/tmp/prowl/#{app.id}_#{app.deploys.last.id}"

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

      output = pre_do_chmod rbox, deploy_options.destination, deploy_options.rev_num
      Rails.logger.debug output
      outputs << output

      output = process_deploy_options rbox, deploy_options, server
      Rails.logger.debug output
      outputs << output

      return outputs
    end

  end
end
