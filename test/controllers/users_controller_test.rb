require 'test_helper'
include Devise::TestHelpers

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:user_for_org_1_admin_access)
    sign_in users(:user_for_org_1_admin_access)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  # test "should create user" do
  #   assert_difference('User.count') do
  #     post :create, user: {  }
  #   end
  #
  #   assert_response 201
  # end

  test "should show user" do
    get :show
    assert_response :success
  end

  # test "should update user" do
  #   put :update, id: @user, user: {  }
  #   assert_response 204
  # end
  #
  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete :destroy, id: @user
  #   end
  #
  #   assert_response 204
  # end
end
