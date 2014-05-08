require 'test_helper'

class EnvsControllerTest < ActionController::TestCase
  setup do
    @env = envs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:envs)
  end

  test "should create env" do
    assert_difference('Env.count') do
      post :create, env: { app_id: @env.app_id, name: @env.name }
    end

    assert_response 201
  end

  test "should show env" do
    get :show, id: @env
    assert_response :success
  end

  test "should update env" do
    put :update, id: @env, env: { app_id: @env.app_id, name: @env.name }
    assert_response 204
  end

  test "should destroy env" do
    assert_difference('Env.count', -1) do
      delete :destroy, id: @env
    end

    assert_response 204
  end
end
