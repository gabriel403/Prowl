require 'test_helper'

class OrganisationsControllerTest < ActionController::TestCase
  setup do
    @organisation = organisations(:fusions)
    sign_in users(:user_for_org_1_admin_access)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organisations)
  end

  test "should create organisation" do
    sign_in users(:user_for_org_nil_nil_access)

    assert_difference('Organisation.count') do
      post :create, organisation: { access_code: (0...50).map { ('a'..'z').to_a[rand(26)] }.join, name: @organisation.name }
    end

    assert_response 201
  end

  test "should show organisation" do
    get :show, id: @organisation
    assert_response :success
  end

  test "should update organisation" do
    put :update, id: @organisation, organisation: { access_code: @organisation.access_code, name: @organisation.name }
    assert_response 204
  end

  test "should destroy organisation" do
    assert_difference('Organisation.count', -1) do
      delete :destroy, id: @organisation
    end

    assert_response 204
  end
end
