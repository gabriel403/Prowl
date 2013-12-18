class CreateAppsServers < ActiveRecord::Migration
  def change
    create_table :apps_servers do |t|
      t.integer :app_id
      t.integer :server_id
      t.timestamps
    end
    add_index :apps_servers, [:app_id, :server_id], :unique => true
  end
end