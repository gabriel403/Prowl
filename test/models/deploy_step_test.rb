require 'test_helper'

class DeployStepTest < ActiveSupport::TestCase

  test "should save DeployStep" do
    ds = DeployStep.new
    ds.env_id = envs(:fusions_dev).id
    ds.order = 0
    ds.deploy_step_type_option_id = deploy_step_type_options(:update).id
    ds.value = 'something'
    ds.additional = '{}'
    assert ds.save
  end

  test "should not save DeployStep due to no env_id" do
    ds = DeployStep.new
    ds.order = 0
    ds.deploy_step_type_option_id = deploy_step_type_options(:update).id
    ds.value = 'admin'
    ds.additional = '{}'
    assert_not ds.save
  end

  test "should not save DeployStep due to no deploy_step_type_option" do
    ds = DeployStep.new
    ds.env_id = envs(:fusions_dev).id
    ds.order = 0
    ds.value = 'admin'
    ds.additional = '{}'
    assert_not ds.save
  end

  test "should save DeployStep with no order" do
    ds = DeployStep.new
    ds.env_id = envs(:fusions_dev).id
    ds.deploy_step_type_option_id = deploy_step_type_options(:update).id
    ds.value = 'admin'
    ds.additional = '{}'
    assert ds.save
  end

  test "should save DeployStep with no value" do
    ds = DeployStep.new
    ds.env_id = envs(:fusions_dev).id
    ds.order = 0
    ds.deploy_step_type_option_id = deploy_step_type_options(:update).id
    ds.additional = '{}'
    assert ds.save
  end

  test "should save DeployStep with no additional" do
    ds = DeployStep.new
    ds.env_id = envs(:fusions_dev).id
    ds.order = 0
    ds.deploy_step_type_option_id = deploy_step_type_options(:update).id
    ds.value = 'admin'
    assert ds.save
  end

end
