require 'test_helper'

class EnvUsersControllerTest < ActionController::TestCase
  setup do
    @env_user = env_users(:one)
    sign_in users(:user1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:env_users)
  end

  # test "should create env_user" do
  #   assert_difference('EnvUser.count') do
  #     post :create, env_user: { access_level_id: @env_user.access_level_id, env_id: @env_user.env_id, user_id: @env_user.user_id }
  #   end
  #
  #   assert_response 201
  # end

  test "should show env_user" do
    get :show, id: @env_user
    assert_response :success
  end

  test "should update env_user" do
    put :update, id: @env_user, env_user: { access_level_id: @env_user.access_level_id, env_id: @env_user.env_id, user_id: @env_user.user_id }
    assert_response 204
  end

  test "should destroy env_user" do
    assert_difference('EnvUser.count', -1) do
      delete :destroy, id: @env_user
    end

    assert_response 204
  end
end
