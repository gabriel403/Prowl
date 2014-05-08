require 'test_helper'

class DeployStepTypesControllerTest < ActionController::TestCase
  setup do
    @deploy_step_type = deploy_step_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deploy_step_types)
  end

  test "should create deploy_step_type" do
    assert_difference('DeployStepType.count') do
      post :create, deploy_step_type: { name: @deploy_step_type.name, subtype: @deploy_step_type.subtype }
    end

    assert_response 201
  end

  test "should show deploy_step_type" do
    get :show, id: @deploy_step_type
    assert_response :success
  end

  test "should update deploy_step_type" do
    put :update, id: @deploy_step_type, deploy_step_type: { name: @deploy_step_type.name, subtype: @deploy_step_type.subtype }
    assert_response 204
  end

  test "should destroy deploy_step_type" do
    assert_difference('DeployStepType.count', -1) do
      delete :destroy, id: @deploy_step_type
    end

    assert_response 204
  end
end
