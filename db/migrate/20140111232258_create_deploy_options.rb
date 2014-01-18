class CreateDeployOptions < ActiveRecord::Migration
  def change
    create_table :deploy_options do |t|
      t.string :value
      t.references :deploy_option_type, index: true
      t.references :deploy, index: true

      t.timestamps
    end
  end
end
