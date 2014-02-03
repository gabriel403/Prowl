module Remoteserver
  class FileOperations
    def set_sudo(rbox, server)
      output = ''
      if server.can_sudo
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

    def process_deploy_options(rbox, fs_chs, server)
      outputs = []
      if fs_chs
        fs_chs.each do |fs_ch|
          if "chown_dir" == fs_ch.deploy_step_type_option.name && !server.can_sudo
            # error
          elsif "chown_dir" == fs_ch.deploy_step_type_option.name
            rbox.mkdir :p, "/home/#{server.username}/bin"

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

            # output = rbox.chown :R, fs_ch.additional['owner'], fs_ch.value
            Resque.logger.debug output
          elsif "chmod_dir" == fs_ch.deploy_step_type_option.name
            output = rbox.chmod :R, fs_ch.additional['perms'], fs_ch.value
            Resque.logger.debug output
          end
        end
      end
      return outputs
    end
  end
end