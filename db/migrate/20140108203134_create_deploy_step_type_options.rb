class CreateDeployStepTypeOptions < ActiveRecord::Migration
  def change
    create_table :deploy_step_type_options do |t|
      t.string :name
      t.references :deploy_step_type, index: true
    end

    # populate the table
    DeployStepTypeOption.create :name => "update_pull",      :deploy_step_type => DeployStepType.find_by(:name => :deploy_method)
    DeployStepTypeOption.create :name => "checkout_clone",   :deploy_step_type => DeployStepType.find_by(:name => :deploy_method)
    DeployStepTypeOption.create :name => "export_clone",     :deploy_step_type => DeployStepType.find_by(:name => :deploy_method)

    DeployStepTypeOption.create :name => "local",            :deploy_step_type => DeployStepType.find_by(:name => :deploy_location)
    DeployStepTypeOption.create :name => "remote",           :deploy_step_type => DeployStepType.find_by(:name => :deploy_location)

    DeployStepTypeOption.create :name => "destination",      :deploy_step_type => DeployStepType.find_by(:name => :destination)

    DeployStepTypeOption.create :name => "git",              :deploy_step_type => DeployStepType.find_by(:name => :vcs_type)
    DeployStepTypeOption.create :name => "svn",              :deploy_step_type => DeployStepType.find_by(:name => :vcs_type)

    DeployStepTypeOption.create :name => "auth_username",    :deploy_step_type => DeployStepType.find_by(:name => :vcs_auth)
    DeployStepTypeOption.create :name => "auth_value",       :deploy_step_type => DeployStepType.find_by(:name => :vcs_auth)

    DeployStepTypeOption.create :name => "vcs_location",     :deploy_step_type => DeployStepType.find_by(:name => :vcs_location)

    DeployStepTypeOption.create :name => "deployed_symlink", :deploy_step_type => DeployStepType.find_by(:name => :deployed_symlink)

    DeployStepTypeOption.create :name => "chown_dir",        :deploy_step_type => DeployStepType.find_by(:name => :ch_dir)
    DeployStepTypeOption.create :name => "chmod_dir",        :deploy_step_type => DeployStepType.find_by(:name => :ch_dir)

    DeployStepTypeOption.create :name => "has_sudo",         :deploy_step_type => DeployStepType.find_by(:name => :super_powers)
  end
end
