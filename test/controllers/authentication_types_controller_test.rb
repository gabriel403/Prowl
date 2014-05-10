require 'test_helper'

class AuthenticationTypesControllerTest < ActionController::TestCase
  setup do
    @authentication_type = authentication_types(:password)
    sign_in users(:user1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authentication_types)
  end

  # test "should create authentication_type" do
  #   assert_difference('AuthenticationType.count') do
  #     post :create, authentication_type: { name: @authentication_type.name, short_name: @authentication_type.short_name }
  #   end
  #
  #   assert_response 201
  # end

  test "should show authentication_type" do
    get :show, id: @authentication_type
    assert_response :success
  end

  # test "should update authentication_type" do
  #   put :update, id: @authentication_type, authentication_type: { name: @authentication_type.name, short_name: @authentication_type.short_name }
  #   assert_response 204
  # end
  #
  # test "should destroy authentication_type" do
  #   assert_difference('AuthenticationType.count', -1) do
  #     delete :destroy, id: @authentication_type
  #   end
  #
  #   assert_response 204
  # end
end
