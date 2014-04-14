class DeployOptionForm
  include ActiveModel::Model
  attr_accessor :revision_number
  attr_accessor :use_non_default_branch
  attr_accessor :db_migrate
  attr_accessor :bundle_install
  # bundle install --deployment
  attr_accessor :restart_web_server
end
