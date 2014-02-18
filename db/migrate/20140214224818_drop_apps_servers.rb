class DropAppsServers < ActiveRecord::Migration
  def change
    drop_table :apps_servers
  end
end
