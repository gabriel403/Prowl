# populate the table
AccessLevel.create(:name => "Admin", :value => "admin", :access_type => "org_access") unless AccessLevel.find_by(name: "Admin", access_type: "org_access")
AccessLevel.create(:name => "User",  :value => "user",  :access_type => "org_access") unless AccessLevel.find_by(name: "User",  access_type: "org_access")
AccessLevel.create(:name => "Admin", :value => "admin", :access_type => "env_access") unless AccessLevel.find_by(name: "Admin", access_type: "env_access")
AccessLevel.create(:name => "User",  :value => "user",  :access_type => "env_access") unless AccessLevel.find_by(name: "User",  access_type: "env_access")

# populate the table
AuthenticationType.create(:name => "Password",          :short_name => "password")  unless AuthenticationType.find_by(:name => "Password",          :short_name => "password")
AuthenticationType.create(:name => "Key Pair [file]",   :short_name => "keyfile")   unless AuthenticationType.find_by(:name => "Key Pair [file]",   :short_name => "keyfile")
AuthenticationType.create(:name => "Key Pair [stored]", :short_name => "keystored") unless AuthenticationType.find_by(:name => "Key Pair [stored]", :short_name => "keystored")

# populate the table
DeployStepType.create(:name => "destination",        :subtype => "unordered") unless DeployStepType.find_by(:name => "destination",        :subtype => "unordered")
DeployStepType.create(:name => "deploy_method",      :subtype => "generic")   unless DeployStepType.find_by(:name => "deploy_method",      :subtype => "generic")
DeployStepType.create(:name => "deploy_location",    :subtype => "generic")   unless DeployStepType.find_by(:name => "deploy_location",    :subtype => "generic")
DeployStepType.create(:name => "vcs_type",           :subtype => "generic")   unless DeployStepType.find_by(:name => "vcs_type",           :subtype => "generic")
DeployStepType.create(:name => "vcs_auth",           :subtype => "unordered") unless DeployStepType.find_by(:name => "vcs_auth",           :subtype => "unordered")
DeployStepType.create(:name => "vcs_location",       :subtype => "unordered") unless DeployStepType.find_by(:name => "vcs_location",       :subtype => "unordered")
DeployStepType.create(:name => "vcs_default_branch", :subtype => "unordered") unless DeployStepType.find_by(:name => "vcs_default_branch", :subtype => "unordered")
DeployStepType.create(:name => "deployed_symlink",   :subtype => "unordered") unless DeployStepType.find_by(:name => "deployed_symlink",   :subtype => "unordered")
DeployStepType.create(:name => "ch_dir",             :subtype => "unordered") unless DeployStepType.find_by(:name => "ch_dir",             :subtype => "unordered")
DeployStepType.create(:name => "deploy_hook",        :subtype => "unordered") unless DeployStepType.find_by(:name => "deploy_hook",        :subtype => "unordered")

# populate the table
DeployStepTypeOption.create(:name => "update_pull",      :deploy_step_type => DeployStepType.find_by(:name => :deploy_method))      unless DeployStepTypeOption.find_by(:name => "update_pull",      :deploy_step_type => DeployStepType.find_by(:name => :deploy_method))
DeployStepTypeOption.create(:name => "checkout_clone",   :deploy_step_type => DeployStepType.find_by(:name => :deploy_method))      unless DeployStepTypeOption.find_by(:name => "checkout_clone",   :deploy_step_type => DeployStepType.find_by(:name => :deploy_method))
DeployStepTypeOption.create(:name => "export_clone",     :deploy_step_type => DeployStepType.find_by(:name => :deploy_method))      unless DeployStepTypeOption.find_by(:name => "export_clone",     :deploy_step_type => DeployStepType.find_by(:name => :deploy_method))

DeployStepTypeOption.create(:name => "local",            :deploy_step_type => DeployStepType.find_by(:name => :deploy_location))    unless DeployStepTypeOption.find_by(:name => "local",            :deploy_step_type => DeployStepType.find_by(:name => :deploy_location))
DeployStepTypeOption.create(:name => "remote",           :deploy_step_type => DeployStepType.find_by(:name => :deploy_location))    unless DeployStepTypeOption.find_by(:name => "remote",           :deploy_step_type => DeployStepType.find_by(:name => :deploy_location))

DeployStepTypeOption.create(:name => "destination",      :deploy_step_type => DeployStepType.find_by(:name => :destination))        unless DeployStepTypeOption.find_by(:name => "destination",      :deploy_step_type => DeployStepType.find_by(:name => :destination))

DeployStepTypeOption.create(:name => "git",              :deploy_step_type => DeployStepType.find_by(:name => :vcs_type))           unless DeployStepTypeOption.find_by(:name => "git",              :deploy_step_type => DeployStepType.find_by(:name => :vcs_type))
DeployStepTypeOption.create(:name => "svn",              :deploy_step_type => DeployStepType.find_by(:name => :vcs_type))           unless DeployStepTypeOption.find_by(:name => "svn",              :deploy_step_type => DeployStepType.find_by(:name => :vcs_type))

DeployStepTypeOption.create(:name => "auth_username",    :deploy_step_type => DeployStepType.find_by(:name => :vcs_auth))           unless DeployStepTypeOption.find_by(:name => "auth_username",    :deploy_step_type => DeployStepType.find_by(:name => :vcs_auth))
DeployStepTypeOption.create(:name => "auth_value",       :deploy_step_type => DeployStepType.find_by(:name => :vcs_auth))           unless DeployStepTypeOption.find_by(:name => "auth_value",       :deploy_step_type => DeployStepType.find_by(:name => :vcs_auth))

DeployStepTypeOption.create(:name => "vcs_location",     :deploy_step_type => DeployStepType.find_by(:name => :vcs_location))       unless DeployStepTypeOption.find_by(:name => "vcs_location",     :deploy_step_type => DeployStepType.find_by(:name => :vcs_location))

DeployStepTypeOption.create(:name => "default_branch",   :deploy_step_type => DeployStepType.find_by(:name => :vcs_default_branch)) unless DeployStepTypeOption.find_by(:name => "default_branch",   :deploy_step_type => DeployStepType.find_by(:name => :vcs_default_branch))

DeployStepTypeOption.create(:name => "deployed_symlink", :deploy_step_type => DeployStepType.find_by(:name => :deployed_symlink))   unless DeployStepTypeOption.find_by(:name => "deployed_symlink", :deploy_step_type => DeployStepType.find_by(:name => :deployed_symlink))

DeployStepTypeOption.create(:name => "chown_dir",        :deploy_step_type => DeployStepType.find_by(:name => :ch_dir))             unless DeployStepTypeOption.find_by(:name => "chown_dir",        :deploy_step_type => DeployStepType.find_by(:name => :ch_dir))
DeployStepTypeOption.create(:name => "chmod_dir",        :deploy_step_type => DeployStepType.find_by(:name => :ch_dir))             unless DeployStepTypeOption.find_by(:name => "chmod_dir",        :deploy_step_type => DeployStepType.find_by(:name => :ch_dir))

DeployStepTypeOption.create(:name => "url_payload_name", :deploy_step_type => DeployStepType.find_by(:name => :deploy_hook))        unless DeployStepTypeOption.find_by(:name => "url_payload_name", :deploy_step_type => DeployStepType.find_by(:name => :deploy_hook))

# populate the table
DeployOptionType.create(:name => "revision_number")    unless DeployOptionType.find_by(:name => "revision_number")
DeployOptionType.create(:name => "vcs_branch_name")    unless DeployOptionType.find_by(:name => "vcs_branch_name")
DeployOptionType.create(:name => "db_migrate")         unless DeployOptionType.find_by(:name => "db_migrate")
DeployOptionType.create(:name => "bundle_install")     unless DeployOptionType.find_by(:name => "bundle_install")
DeployOptionType.create(:name => "restart_web_server") unless DeployOptionType.find_by(:name => "restart_web_server")
