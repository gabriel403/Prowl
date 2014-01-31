class AddRailsDeployOptions < ActiveRecord::Migration
  def up
    DeployOptionType.create :name => "db_migrate"
  end
  def down
    dot = DeployOptionType.find_by name: "db_migrate"
    dot.destroy
  end
end
