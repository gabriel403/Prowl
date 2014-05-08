class CreateEnvUsers < ActiveRecord::Migration
  def change
    create_table :env_users do |t|
      t.references :user, index: true
      t.references :env, index: true
      t.references :access_level, index: true

      t.timestamps
    end
  end
end
