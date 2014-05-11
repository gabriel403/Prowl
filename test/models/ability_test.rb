require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  test "user creating org" do
    org = Organisation.new
    org.name = 'something'
    org.access_code = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    ability = Ability.new(users(:user_for_org_nil_nil_access))
    assert ability.can?(:create, org), "user with no org can't create one"

    org = Organisation.new
    org.name = 'somethingelse'
    org.access_code = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    ability = Ability.new(users(:user_for_org_1_admin_access))
    assert ability.cannot?(:create, org), "user belonging to org can create one"
  end

  test "user viewing org" do
    ability = Ability.new(users(:user_for_org_1_admin_access))
    assert ability.can?(:read, organisations(:fusions)), "admin cannot view an org that it belongs to"

    ability = Ability.new(users(:user_for_org_1_user_access))
    assert ability.can?(:read, organisations(:fusions)), "user cannot view an org that it belongs to"

    ability = Ability.new(users(:user_for_org_2_admin_access))
    assert ability.cannot?(:read, organisations(:fusions)), "admin can view an org that it doesn't belongs to"

    ability = Ability.new(users(:user_for_org_2_user_access))
    assert ability.cannot?(:read, organisations(:fusions)), "user can view an org that it doesn't belongs to"

    ability = Ability.new(users(:user_for_org_nil_nil_access))
    assert ability.cannot?(:read, organisations(:fusions)), "user with no org can view an org that it doesn't belongs to"
  end

  test "user viewing app" do
    ability = Ability.new(users(:user_for_org_1_admin_access))
    assert ability.can?(:read, apps(:fusions)), "admin cannot view an app that belongs to a same org"

    ability = Ability.new(users(:user_for_org_1_user_access))
    assert ability.can?(:read, apps(:fusions)), "user cannot view an app that belongs to a same org"

    ability = Ability.new(users(:user_for_org_2_admin_access))
    assert ability.cannot?(:read, apps(:fusions)), "admin viewed an app that belongs to a different org"

    ability = Ability.new(users(:user_for_org_2_user_access))
    assert ability.cannot?(:read, apps(:fusions)), "user viewed an app that belongs to a different org"
  end

  test "should not save App with organisation_id not ours" do
    app = App.new
    app.name = 'app11'
    app.organisation = users(:user_for_org_2_admin_access).organisations.first

    ability = Ability.new(users(:user_for_org_1_admin_access))
    assert ability.cannot?(:create, app), "admin saved an app that belongs to a different org"

    ability = Ability.new(users(:user_for_org_1_user_access))
    assert ability.cannot?(:create, app), "user saved an app that belongs to a different org"
  end

end
