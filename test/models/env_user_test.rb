require 'test_helper'

class EnvUserTest < ActiveSupport::TestCase

  test "should save EnvUser" do
    envuser = EnvUser.new
    envuser.user_id = users(:user_for_org_2_admin_access).id
    envuser.env_id = envs(:prowl_dev).id
    envuser.access_level_id = access_levels(:env_user).id
    assert envuser.save
  end

  test "should not save EnvUser with no user_id" do
    envuser = EnvUser.new
    envuser.env_id = envs(:prowl_dev).id
    envuser.access_level_id = access_levels(:env_user).id
    assert_not envuser.save
  end

  test "should not save EnvUser with user who should not access env due to org" do
    envuser = EnvUser.new
    envuser.user_id = users(:user_for_org_1_admin_access).id
    envuser.env_id = envs(:fusions_dev).id
    envuser.access_level_id = access_levels(:env_user).id
    assert_not envuser.save
  end

  test "should not save EnvUser with no env_id" do
    envuser = EnvUser.new
    envuser.user_id = users(:user_for_org_1_admin_access).id
    envuser.access_level_id = access_levels(:env_user).id
    assert_not envuser.save
  end

  test "should not save EnvUser with no access_level_id" do
    envuser = EnvUser.new
    envuser.user_id = users(:user_for_org_1_admin_access).id
    envuser.env_id = envs(:fusions_dev).id
    assert_not envuser.save
  end



end
