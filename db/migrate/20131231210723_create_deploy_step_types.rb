class CreateDeployStepTypes < ActiveRecord::Migration
  def change
    create_table :deploy_step_types do |t|
      t.string :name
      t.string :subtype, :default => :generic
    end

    # populate the table
    DeployStepType.create :name => "destination",      :subtype => "unordered"
    DeployStepType.create :name => "deploy_method",    :subtype => "generic"
    DeployStepType.create :name => "deploy_location",  :subtype => "generic"
    DeployStepType.create :name => "vcs_type",         :subtype => "generic"
    DeployStepType.create :name => "vcs_auth",         :subtype => "unordered"
    DeployStepType.create :name => "vcs_location",     :subtype => "unordered"
    DeployStepType.create :name => "deployed_symlink", :subtype => "unordered"
    DeployStepType.create :name => "ch_dir",           :subtype => "unordered"
  end
end
