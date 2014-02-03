module Remoteserver
  class DeployOptions
    attr_accessor :destination, :local_remote, :checkout_export_update, :deployed_symlink, :svn_username, :svn_password, :svn_location, :fs_chs, :rev_num

    def initialize(app)

      @destination             = app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "destination"}.value
      @local_remote            = app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_location"}
      @checkout_export_update  = app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_method"}

      @deployed_symlink        = app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deployed_symlink"}

      @svn_username            = app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_username"}.value
      @svn_password            = app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_value"}.value
      @svn_location            = app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "vcs_location"}.value

      @fs_chs                  = app.deploy_steps.find_all {|ds| ds.deploy_step_type_option.deploy_step_type.name == "ch_dir"}

      @rev_num                 = app.deploys.last.deploy_options.find {|doe| doe.deploy_option_type.name == "revision_number"}.value

    end
  end
end