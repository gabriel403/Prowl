require 'test_helper'

class DeployStepsControllerTest < ActionController::TestCase
  setup do
    @deploy_step = deploy_steps(:one)
    sign_in users(:user1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deploy_steps)
  end

  test "should create deploy_step" do
    assert_difference('DeployStep.count') do
      post :create, deploy_step: { additional: @deploy_step.additional, deploy_step_type_option_id: @deploy_step.deploy_step_type_option_id, env_id: @deploy_step.env_id, order: @deploy_step.order, value: @deploy_step.value }
    end

    assert_response 201
  end

  test "should show deploy_step" do
    get :show, id: @deploy_step
    assert_response :success
  end

  test "should update deploy_step" do
    put :update, id: @deploy_step, deploy_step: { additional: @deploy_step.additional, deploy_step_type_option_id: @deploy_step.deploy_step_type_option_id, env_id: @deploy_step.env_id, order: @deploy_step.order, value: @deploy_step.value }
    assert_response 204
  end

  test "should destroy deploy_step" do
    assert_difference('DeployStep.count', -1) do
      delete :destroy, id: @deploy_step
    end

    assert_response 204
  end
end
