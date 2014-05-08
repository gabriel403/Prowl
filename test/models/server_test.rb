require 'test_helper'

class ServerTest < ActiveSupport::TestCase

  test "should save Server" do
    server = Server.new
    server.organisation_id = organisations(:prowl).id
    server.name = 'localhost'
    server.host = 'localhost'
    server.username = 'remote_name'
    server.authentication_type = authentication_types(:keystored)
    server.authentication = 'rsastring'
    server.enabled = true
    server.can_sudo = false
    assert server.save
  end

  test "should not save Server due to no organisation" do
    server = Server.new
    server.name = 'localhost'
    server.host = 'localhost'
    server.username = 'remote_name'
    server.authentication_type = authentication_types(:keystored)
    server.authentication = 'rsastring'
    server.enabled = true
    server.can_sudo = false
    assert_not server.save
  end

  test "should not save Server due to no name" do
    server = Server.new
    server.organisation_id = organisations(:prowl).id
    server.host = 'localhost'
    server.username = 'remote_name'
    server.authentication_type = authentication_types(:keystored)
    server.authentication = 'rsastring'
    server.enabled = true
    server.can_sudo = false
    assert_not server.save
  end

  test "should not save Server due to no host" do
    server = Server.new
    server.organisation_id = organisations(:prowl).id
    server.name = 'localhost'
    server.username = 'remote_name'
    server.authentication_type = authentication_types(:keystored)
    server.authentication = 'rsastring'
    server.enabled = true
    server.can_sudo = false
    assert_not server.save
  end

  test "should not save Server due to no username" do
    server = Server.new
    server.organisation_id = organisations(:prowl).id
    server.name = 'localhost'
    server.host = 'localhost'
    server.authentication_type = authentication_types(:keystored)
    server.authentication = 'rsastring'
    server.enabled = true
    server.can_sudo = false
    assert_not server.save
  end

  test "should not save Server due to no auth_type" do
    server = Server.new
    server.organisation_id = organisations(:prowl).id
    server.name = 'localhost'
    server.host = 'localhost'
    server.username = 'remote_name'
    server.authentication = 'rsastring'
    server.enabled = true
    server.can_sudo = false
    assert_not server.save
  end

  test "should not save Server due to no auth_value" do
    server = Server.new
    server.organisation_id = organisations(:prowl).id
    server.name = 'localhost'
    server.host = 'localhost'
    server.username = 'remote_name'
    server.authentication_type = authentication_types(:keystored)
    server.enabled = true
    server.can_sudo = false
    assert_not server.save
  end

end
