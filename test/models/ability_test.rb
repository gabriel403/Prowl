require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  # test "user can only destroy projects which he owns" do
  #   user = User.create!
  #   assert ability.can?(:destroy, Project.new(:user => user))
  #   assert ability.cannot?(:destroy, Project.new)
  # end

  test "can view app belonging to same org" do
    ability = Ability.new(users(:user_for_org_1_admin_access))
    assert ability.can?(:read, apps(:fusions)), "admin cannot view an app that belongs to a same org"

    ability = Ability.new(users(:user_for_org_1_user_access))
    assert ability.can?(:read, apps(:fusions)), "user cannot view an app that belongs to a same org"
  end

  test "cannot view app belonging to different org" do
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
