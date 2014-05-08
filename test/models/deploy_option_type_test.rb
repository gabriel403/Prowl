require 'test_helper'

class DeployOptionTypeTest < ActiveSupport::TestCase

  test "should save DeployOptionType" do
    deployoptiontype = DeployOptionType.new
    deployoptiontype.name = 'some name'
    assert deployoptiontype.save
  end

  test "should not save DeployOptionType due to no name" do
    deployoptiontype = DeployOptionType.new
    assert_not deployoptiontype.save
  end

end
