require 'test_helper'

class DeployOptionsControllerTest < ActionController::TestCase
  setup do
    @deploy_option = deploy_options(:one)
    sign_in users(:user_for_org_1_admin_access)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deploy_options)
  end

  test "should create deploy_option" do
    assert_difference('DeployOption.count') do
      post :create, deploy_option: { deploy_id: @deploy_option.deploy_id, deploy_option_type_id: @deploy_option.deploy_option_type_id, value: @deploy_option.value }
    end

    assert_response 201
  end

  test "should show deploy_option" do
    get :show, id: @deploy_option
    assert_response :success
  end

  test "should update deploy_option" do
    put :update, id: @deploy_option, deploy_option: { deploy_id: @deploy_option.deploy_id, deploy_option_type_id: @deploy_option.deploy_option_type_id, value: @deploy_option.value }
    assert_response 204
  end

  test "should destroy deploy_option" do
    assert_difference('DeployOption.count', -1) do
      delete :destroy, id: @deploy_option
    end

    assert_response 204
  end
end
