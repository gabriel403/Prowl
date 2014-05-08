class CreateEnvs < ActiveRecord::Migration
  def change
    create_table :envs do |t|
      t.string :name
      t.references :app, index: true

      t.timestamps
    end
  end
end
