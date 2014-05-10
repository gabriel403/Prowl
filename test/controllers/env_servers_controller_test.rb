require 'test_helper'

class EnvServersControllerTest < ActionController::TestCase
  setup do
    @env_server = env_servers(:fusions_localhost_dev)
    sign_in users(:user1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:env_servers)
  end

  # test "should create env_server" do
  #   assert_difference('EnvServer.count') do
  #     post :create, env_server: { env_id: @env_server.env_id, server_id: @env_server.server_id }
  #   end
  #
  #   assert_response 201
  # end

  test "should show env_server" do
    get :show, id: @env_server
    assert_response :success
  end

  test "should update env_server" do
    put :update, id: @env_server, env_server: { env_id: @env_server.env_id, server_id: @env_server.server_id }
    assert_response 204
  end

  test "should destroy env_server" do
    assert_difference('EnvServer.count', -1) do
      delete :destroy, id: @env_server
    end

    assert_response 204
  end
end
