require 'test_helper'

class OrganisationUserTest < ActiveSupport::TestCase

  test "should save OrganisationUser" do
    orguser = OrganisationUser.new
    orguser.user_id = users(:user4).id
    orguser.organisation_id = organisations(:prowl).id
    orguser.access_level_id = access_levels(:org_user).id
    assert orguser.save
  end

  test "should not save OrganisationUser due to same user in multiple orgs" do
    orguser = OrganisationUser.new
    orguser.user_id = users(:user4).id
    orguser.organisation_id = organisations(:prowl).id
    orguser.access_level_id = access_levels(:org_user).id
    assert orguser.save

    orguser = OrganisationUser.new
    orguser.user_id = users(:user4).id
    orguser.organisation_id = organisations(:fusions).id
    orguser.access_level_id = access_levels(:org_user).id
    assert_not orguser.save

  end

end
