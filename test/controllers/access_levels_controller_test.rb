require 'test_helper'

class AccessLevelsControllerTest < ActionController::TestCase
  setup do
    @access_level = access_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:access_levels)
  end

  test "should create access_level" do
    assert_difference('AccessLevel.count') do
      post :create, access_level: { access_type: @access_level.access_type, name: @access_level.name, value: @access_level.value }
    end

    assert_response 201
  end

  test "should show access_level" do
    get :show, id: @access_level
    assert_response :success
  end

  test "should update access_level" do
    put :update, id: @access_level, access_level: { access_type: @access_level.access_type, name: @access_level.name, value: @access_level.value }
    assert_response 204
  end

  test "should destroy access_level" do
    assert_difference('AccessLevel.count', -1) do
      delete :destroy, id: @access_level
    end

    assert_response 204
  end
end
