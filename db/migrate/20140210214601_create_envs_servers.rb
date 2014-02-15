class CreateEnvsServers < ActiveRecord::Migration
  def change
    create_table :environments_servers do |t|
      t.integer :environment_id
      t.integer :server_id
    end
    add_index :environments_servers, [:environment_id, :server_id], :unique => true
  end
end