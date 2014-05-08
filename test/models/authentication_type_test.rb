require 'test_helper'

class AuthenticationTypeTest < ActiveSupport::TestCase

  test "should save AuthenticationType" do
    at = AuthenticationType.new
    at.name = 'something'
    at.short_name = 'st'
    assert at.save
  end

  test "should not save AuthenticationType with no name" do
    at = AuthenticationType.new
    at.short_name = 'st'
    assert_not at.save
  end

  test "should not save AuthenticationType with no short_name" do
    at = AuthenticationType.new
    at.name = 'something'
    assert_not at.save
  end
end
