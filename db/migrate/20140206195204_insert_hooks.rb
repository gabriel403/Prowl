class InsertHooks < ActiveRecord::Migration
  def up
    DeployStepType.create       :name => "deploy_hook",      :subtype => "unordered"
    DeployStepTypeOption.create :name => "url_payload_name", :deploy_step_type => DeployStepType.find_by(:name => :deploy_hook)
  end
end
