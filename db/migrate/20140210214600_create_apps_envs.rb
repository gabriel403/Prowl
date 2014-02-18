class CreateAppsEnvs < ActiveRecord::Migration
  def change
    create_table :apps_environments do |t|
      t.integer :app_id
      t.integer :environment_id
    end
    add_index :apps_environments, [:app_id, :environment_id], :unique => true
  end
end