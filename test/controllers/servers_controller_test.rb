require 'test_helper'

class ServersControllerTest < ActionController::TestCase
  setup do
    @server = servers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:servers)
  end

  test "should create server" do
    assert_difference('Server.count') do
      post :create, server: { authentication: @server.authentication, authentication_type_id: @server.authentication_type_id, can_sudo: @server.can_sudo, enabled: @server.enabled, host: @server.host, name: @server.name, organisation_id: @server.organisation_id, port: @server.port, sudo_password: @server.sudo_password, username: @server.username }
    end

    assert_response 201
  end

  test "should show server" do
    get :show, id: @server
    assert_response :success
  end

  test "should update server" do
    put :update, id: @server, server: { authentication: @server.authentication, authentication_type_id: @server.authentication_type_id, can_sudo: @server.can_sudo, enabled: @server.enabled, host: @server.host, name: @server.name, organisation_id: @server.organisation_id, port: @server.port, sudo_password: @server.sudo_password, username: @server.username }
    assert_response 204
  end

  test "should destroy server" do
    assert_difference('Server.count', -1) do
      delete :destroy, id: @server
    end

    assert_response 204
  end
end
