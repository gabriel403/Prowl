# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# populate the table
AuthenticationType.create! :name => "Password",          :short_name => "password"
AuthenticationType.create! :name => "Key Pair [file]",   :short_name => "keyfile"
AuthenticationType.create! :name => "Key Pair [stored]", :short_name => "keystored"

# populate the table
AppSetup.create! :name => "app_name",           :value => "Prowl"
AppSetup.create! :name => "registrations_open", :value => 'true'

# populate the table
DeployStepType.create! :name => "destination",      :subtype => "unordered"
DeployStepType.create! :name => "deploy_method",    :subtype => "generic"
DeployStepType.create! :name => "deploy_location",  :subtype => "generic"
DeployStepType.create! :name => "vcs_type",         :subtype => "generic"
DeployStepType.create! :name => "vcs_auth",         :subtype => "unordered"
DeployStepType.create! :name => "vcs_location",     :subtype => "unordered"
DeployStepType.create! :name => "deployed_symlink", :subtype => "unordered"
DeployStepType.create! :name => "ch_dir",           :subtype => "unordered"
DeployStepType.create! :name => "deploy_hook",      :subtype => "unordered"

# populate the table
DeployStepTypeOption.create! :name => "update_pull",      :deploy_step_type => DeployStepType.find_by(:name => :deploy_method)
DeployStepTypeOption.create! :name => "checkout_clone",   :deploy_step_type => DeployStepType.find_by(:name => :deploy_method)
DeployStepTypeOption.create! :name => "export_clone",     :deploy_step_type => DeployStepType.find_by(:name => :deploy_method)

DeployStepTypeOption.create! :name => "local",            :deploy_step_type => DeployStepType.find_by(:name => :deploy_location)
DeployStepTypeOption.create! :name => "remote",           :deploy_step_type => DeployStepType.find_by(:name => :deploy_location)

DeployStepTypeOption.create! :name => "destination",      :deploy_step_type => DeployStepType.find_by(:name => :destination)

DeployStepTypeOption.create! :name => "git",              :deploy_step_type => DeployStepType.find_by(:name => :vcs_type)
DeployStepTypeOption.create! :name => "svn",              :deploy_step_type => DeployStepType.find_by(:name => :vcs_type)

DeployStepTypeOption.create! :name => "auth_username",    :deploy_step_type => DeployStepType.find_by(:name => :vcs_auth)
DeployStepTypeOption.create! :name => "auth_value",       :deploy_step_type => DeployStepType.find_by(:name => :vcs_auth)

DeployStepTypeOption.create! :name => "vcs_location",     :deploy_step_type => DeployStepType.find_by(:name => :vcs_location)

DeployStepTypeOption.create! :name => "deployed_symlink", :deploy_step_type => DeployStepType.find_by(:name => :deployed_symlink)

DeployStepTypeOption.create! :name => "chown_dir",        :deploy_step_type => DeployStepType.find_by(:name => :ch_dir)
DeployStepTypeOption.create! :name => "chmod_dir",        :deploy_step_type => DeployStepType.find_by(:name => :ch_dir)

DeployStepTypeOption.create! :name => "url_payload_name",              :deploy_step_type => DeployStepType.find_by(:name => :deploy_hook)

DeployOptionType.create! :name => "revision_number"
DeployOptionType.create! :name => "branch_name"
DeployOptionType.create! :name => "db_migrate"
DeployOptionType.create! :name => "bundle_install"
DeployOptionType.create! :name => "restart_web_server"