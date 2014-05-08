class CreateDeployStepTypeOptions < ActiveRecord::Migration
  def change
    create_table :deploy_step_type_options do |t|
      t.string :name
      t.references :deploy_step_type, index: true

      t.timestamps
    end
    add_index :deploy_step_type_options, :name, unique: true
  end
end
