require 'test_helper'

class DeploysControllerTest < ActionController::TestCase
  setup do
    @deploy = deploys(:fusions_deploy)
    sign_in users(:user_for_org_1_admin_access)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deploys)
  end

  test "should create deploy" do
    assert_difference('Deploy.count') do
      post :create, deploy: { env_id: @deploy.env_id, output: @deploy.output, server_id: @deploy.server_id, status: @deploy.status, user_id: @deploy.user_id }
    end

    assert_response 201
  end

  test "should show deploy" do
    get :show, id: @deploy
    assert_response :success
  end

  test "should update deploy" do
    put :update, id: @deploy, deploy: { env_id: @deploy.env_id, output: @deploy.output, server_id: @deploy.server_id, status: @deploy.status, user_id: @deploy.user_id }
    assert_response 204
  end

  test "should destroy deploy" do
    assert_difference('Deploy.count', -1) do
      delete :destroy, id: @deploy
    end

    assert_response 204
  end
end
