require 'test_helper'

class DeploysControllerTest < ActionController::TestCase
  setup do
    @deploy = deploys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deploys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deploy" do
    assert_difference('Deploy.count') do
      post :create, deploy: {  }
    end

    assert_redirected_to deploy_path(assigns(:deploy))
  end

  test "should show deploy" do
    get :show, id: @deploy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deploy
    assert_response :success
  end

  test "should update deploy" do
    patch :update, id: @deploy, deploy: {  }
    assert_redirected_to deploy_path(assigns(:deploy))
  end

  test "should destroy deploy" do
    assert_difference('Deploy.count', -1) do
      delete :destroy, id: @deploy
    end

    assert_redirected_to deploys_path
  end
end
