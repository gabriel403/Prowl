require 'test_helper'

class DeployOptionTest < ActiveSupport::TestCase

  test "should save DeployOption" do
    deployoption = DeployOption.new
    deployoption.value = '1'
    deployoption.deploy_option_type_id = deploy_option_types(:revision_number).id
    deployoption.deploy_id = deploys(:fusions_deploy).id
    assert deployoption.save
  end

  test "should not save DeployOption due to no value" do
    deployoption = DeployOption.new
    deployoption.deploy_option_type_id = deploy_option_types(:revision_number).id
    deployoption.deploy_id = deploys(:fusions_deploy).id
    assert_not deployoption.save
  end

  test "should not save DeployOption due to no deploy_option_type" do
    deployoption = DeployOption.new
    deployoption.value = '1'
    deployoption.deploy_id = deploys(:fusions_deploy).id
    assert_not deployoption.save
  end

  test "should not save DeployOption due to no deploy_id" do
    deployoption = DeployOption.new
    deployoption.value = '1'
    deployoption.deploy_option_type_id = deploy_option_types(:revision_number).id
    assert_not deployoption.save
  end

end
