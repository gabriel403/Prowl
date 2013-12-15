module Myserver
  class Test

    def testy
      Net::SSH.start("127.0.0.1", "wheeljack", :keys_only => true, :keys => ['/code/Wheeljack/puppet/modules/users/files/wheeljack/id_rsa']) do |ssh|
        ssh.exec!("cd /code/Prowl")
        result = ssh.exec!("ls -alh")
        puts result
      end
    end

  end
end