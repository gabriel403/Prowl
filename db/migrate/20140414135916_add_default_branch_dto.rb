class AddDefaultBranchDto < ActiveRecord::Migration
  def up
    DeployStepType.create! :name => "vcs_default_branch", :subtype => "unordered"
    DeployStepTypeOption.create! :name => "vcs_default_branch",      :deploy_step_type => DeployStepType.find_by(:name => :vcs_default_branch)
  end

  def down
    DeployStepType.destroy_all(name: "vcs_default_branch")
    DeployStepTypeOption.destroy_all(name: "vcs_default_branch")
  end
end
