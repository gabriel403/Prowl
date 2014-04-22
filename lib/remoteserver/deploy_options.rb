module Remoteserver
  class DeployOptions
    attr_accessor :destination, :local_remote, :checkout_export_update, :deployed_symlink, :vcs_username, :vcs_password, :vcs_location, :fs_chs, :rev_num, :branch_name, :hooks, :vcs_default_branch

    def initialize(env)

      @destination             = env.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "destination"}.value
      @local_remote            = env.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_location"}
      @checkout_export_update  = env.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_method"}

      @deployed_symlink        = env.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deployed_symlink"}

      @vcs_username            = env.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_username"}
      @vcs_username            = @vcs_username ? @vcs_username.value : @vcs_username

      @vcs_password            = env.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_value"}
      @vcs_password            = @vcs_password ? @vcs_password.value : @vcs_password

      @vcs_location            = env.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "vcs_location"}
      @vcs_location            = @vcs_location ? @vcs_location.value : @vcs_location
      @vcs_default_branch      = env.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "vcs_default_branch"}
      @vcs_default_branch      = @vcs_default_branch ? @vcs_default_branch.value : @vcs_default_branch

      @fs_chs                  = env.deploy_steps.find_all {|ds| ds.deploy_step_type_option.deploy_step_type.name == "ch_dir"}

      @hooks                   = env.deploy_steps.find_all {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_hook"}

      @rev_num                 = false
      @branch_name             = false

      if env.deploys.last
        @rev_num                 = env.deploys.last.deploy_options.find {|doe| doe.deploy_option_type.name == "revision_number"}
        @rev_num                 = @rev_num ? @rev_num.value : @rev_num
        @branch_name             = env.deploys.last.deploy_options.find {|doe| doe.deploy_option_type.name == "branch_name"}
        @branch_name             = @branch_name ? @branch_name.value : @branch_name
      end

    end
  end
end
