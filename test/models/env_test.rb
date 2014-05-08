require 'test_helper'

class EnvTest < ActiveSupport::TestCase

  test "should save Env" do
    env = Env.new
    env.name = 'something'
    env.app_id = 1
    assert env.save
  end

  test "should not save Env without name" do
    env = Env.new
    env.app_id = 1
    assert_not env.save
  end

  test "should not save Env without app_id" do
    env = Env.new
    env.name = 'something'
    assert_not env.save
  end

  test "should not save Env with invalid app_id" do
    env = Env.new
    env.name = 'something'
    env.app_id = 20
    assert_not env.save
  end

end
