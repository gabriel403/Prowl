require 'test_helper'

class OrganisationUsersControllerTest < ActionController::TestCase
  setup do
    @organisation_user = organisation_users(:org_1_admin)
    sign_in users(:user_for_org_1_admin_access)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organisation_users)
  end

  # test "should create organisation_user" do
  #   assert_difference('OrganisationUser.count') do
  #     post :create, organisation_user: { access_level_id: @organisation_user.access_level_id, organisation_id: @organisation_user.organisation_id, user_id: @organisation_user.user_id }
  #   end
  #
  #   assert_response 201
  # end

  test "should show organisation_user" do
    get :show, id: @organisation_user
    assert_response :success
  end

  test "should update organisation_user" do
    put :update, id: @organisation_user, organisation_user: { access_level_id: @organisation_user.access_level_id, organisation_id: @organisation_user.organisation_id, user_id: @organisation_user.user_id }
    assert_response 204
  end

  test "should destroy organisation_user" do
    assert_difference('OrganisationUser.count', -1) do
      delete :destroy, id: @organisation_user
    end

    assert_response 204
  end
end
