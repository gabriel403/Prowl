require 'test_helper'

class OrganisationTest < ActiveSupport::TestCase

  test "should save Organisation" do
    org = Organisation.new
    org.name = 'something'
    org.access_code = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    assert org.save
  end

  test "should not save Organisation due to no name" do
    org = Organisation.new
    org.access_code = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    assert_not org.save
  end

  test "should not save Organisation due to no access_code" do
    org = Organisation.new
    org.name = 'something'
    assert_not org.save
  end

  test "should not save Organisation due to duplicate access_code" do
    org = Organisation.new
    org.name = 'something'
    org.access_code = organisations(:prowl).access_code
    assert_not org.save
  end

end
