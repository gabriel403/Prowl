require 'test_helper'

class DeployStepsControllerTest < ActionController::TestCase
  setup do
    @deploy_step = deploy_steps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deploy_steps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deploy_step" do
    assert_difference('DeployStep.count') do
      post :create, deploy_step: {  }
    end

    assert_redirected_to deploy_step_path(assigns(:deploy_step))
  end

  test "should show deploy_step" do
    get :show, id: @deploy_step
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deploy_step
    assert_response :success
  end

  test "should update deploy_step" do
    patch :update, id: @deploy_step, deploy_step: {  }
    assert_redirected_to deploy_step_path(assigns(:deploy_step))
  end

  test "should destroy deploy_step" do
    assert_difference('DeployStep.count', -1) do
      delete :destroy, id: @deploy_step
    end

    assert_redirected_to deploy_steps_path
  end
end
