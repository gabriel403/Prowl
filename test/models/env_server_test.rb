require 'test_helper'

class EnvServerTest < ActiveSupport::TestCase

  test "should save EnvServer" do
    envserver = EnvServer.new
    envserver.env_id = envs(:fusions_dev).id
    envserver.server_id = servers(:fusions_localhost).id
    assert envserver.save
  end

  test "should not save EnvServer with no env_id" do
    envserver = EnvServer.new
    envserver.server_id = servers(:fusions_localhost).id
    assert_not envserver.save
  end

  test "should not save EnvServer with no server_id" do
    envserver = EnvServer.new
    envserver.env_id = envs(:fusions_dev).id
    assert_not envserver.save
  end

  test "should not save EnvServer when server and env don't belong to same organisation" do
    envserver = EnvServer.new
    envserver.env_id = envs(:fusions_dev).id
    envserver.server_id = servers(:prowl_localhost).id
    assert_not envserver.save
  end


  test "should not save EnvServer twice" do
    envserver = EnvServer.new
    envserver.env_id = envs(:fusions_dev).id
    envserver.server_id = servers(:fusions_localhost).id
    envserver.save

    envserver = EnvServer.new
    envserver.env_id = envs(:fusions_dev).id
    envserver.server_id = servers(:fusions_localhost).id
    assert_not envserver.save
  end

end
