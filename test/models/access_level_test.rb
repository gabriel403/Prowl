require 'test_helper'

class AccessLevelTest < ActiveSupport::TestCase

  test "should save AccessLevel" do
    accesslevel = AccessLevel.new
    accesslevel.name = 'Admin'
    accesslevel.value = 'admin'
    accesslevel.access_type = 'env_access'
    assert accesslevel.save
  end

  test "should not save AccessLevel due to no name" do
    accesslevel = AccessLevel.new
    accesslevel.value = 'admin'
    accesslevel.access_type = 'env_access'
    assert_not accesslevel.save
  end

  test "should not save AccessLevel due to no value" do
    accesslevel = AccessLevel.new
    accesslevel.name = 'Admin'
    accesslevel.access_type = 'env_access'
    assert_not accesslevel.save
  end

  test "should not save AccessLevel due to no access_type" do
    accesslevel = AccessLevel.new
    accesslevel.name = 'Admin'
    accesslevel.value = 'admin'
    assert_not accesslevel.save
  end

end
