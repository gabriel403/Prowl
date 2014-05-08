class CreateEnvServers < ActiveRecord::Migration
  def change
    create_table :env_servers do |t|
      t.references :env, index: true
      t.references :server, index: true

      t.timestamps
    end
  end
end
