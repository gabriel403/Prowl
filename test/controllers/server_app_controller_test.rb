require 'test_helper'

class ServerAppControllerTest < ActionController::TestCase
  test "should get link" do
    get :link
    assert_response :success
  end

end
