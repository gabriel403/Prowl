require 'test_helper'

class AppsControllerTest < ActionController::TestCase
  setup do
    @app = apps(:fusions)
    sign_in users(:user1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apps)
  end

  test "should create app" do
    assert_difference('App.count') do
      post :create, app: { name: @app.name, organisation_id: @app.organisation_id }
    end

    assert_response 201
  end

  test "should show app" do
    get :show, id: @app
    assert_response :success
  end

  test "should update app" do
    put :update, id: @app, app: { name: @app.name, organisation_id: @app.organisation_id }
    assert_response 204
  end

  test "should destroy app" do
    assert_difference('App.count', -1) do
      delete :destroy, id: @app
    end

    assert_response 204
  end
end
