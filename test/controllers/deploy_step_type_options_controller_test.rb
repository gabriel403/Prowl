require 'test_helper'

class DeployStepTypeOptionsControllerTest < ActionController::TestCase
  setup do
    @deploy_step_type_option = deploy_step_type_options(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deploy_step_type_options)
  end

  test "should create deploy_step_type_option" do
    assert_difference('DeployStepTypeOption.count') do
      post :create, deploy_step_type_option: { deploy_step_type_id: @deploy_step_type_option.deploy_step_type_id, name: @deploy_step_type_option.name }
    end

    assert_response 201
  end

  test "should show deploy_step_type_option" do
    get :show, id: @deploy_step_type_option
    assert_response :success
  end

  test "should update deploy_step_type_option" do
    put :update, id: @deploy_step_type_option, deploy_step_type_option: { deploy_step_type_id: @deploy_step_type_option.deploy_step_type_id, name: @deploy_step_type_option.name }
    assert_response 204
  end

  test "should destroy deploy_step_type_option" do
    assert_difference('DeployStepTypeOption.count', -1) do
      delete :destroy, id: @deploy_step_type_option
    end

    assert_response 204
  end
end
