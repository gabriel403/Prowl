class AddRailsDeployOptions < ActiveRecord::Migration
  def up
    DeployOptionType.create :name => "db_migrate"
    DeployOptionType.create :name => "bundle_install"
    DeployOptionType.create :name => "restart_web_server"
  end
  def down
    DeployOptionType.destroy_all(name: "db_migrate")
    DeployOptionType.destroy_all(name: "bundle_install")
    DeployOptionType.destroy_all(name: "restart_web_server")
  end
end
