require 'test_helper'

class DeployOptionTypesControllerTest < ActionController::TestCase
  setup do
    @deploy_option_type = deploy_option_types(:revision_number)
    sign_in users(:user_for_org_1_admin_access)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deploy_option_types)
  end

  # test "should create deploy_option_type" do
  #   assert_difference('DeployOptionType.count') do
  #     post :create, deploy_option_type: { name: @deploy_option_type.name }
  #   end
  #
  #   assert_response 201
  # end

  test "should show deploy_option_type" do
    get :show, id: @deploy_option_type
    assert_response :success
  end

  # test "should update deploy_option_type" do
  #   put :update, id: @deploy_option_type, deploy_option_type: { name: @deploy_option_type.name }
  #   assert_response 204
  # end
  #
  # test "should destroy deploy_option_type" do
  #   assert_difference('DeployOptionType.count', -1) do
  #     delete :destroy, id: @deploy_option_type
  #   end
  #
  #   assert_response 204
  # end
end
