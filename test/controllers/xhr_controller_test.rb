require 'test_helper'

class XhrControllerTest < ActionController::TestCase
  test "should get deploy_step_type" do
    get :deploy_step_type
    assert_response :success
  end

end
