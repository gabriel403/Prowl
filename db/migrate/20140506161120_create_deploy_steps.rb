class CreateDeploySteps < ActiveRecord::Migration
  def change
    create_table :deploy_steps do |t|
      t.references :env, index: true
      t.integer :order
      t.references :deploy_step_type_option, index: true
      t.string :value
      t.string :additional

      t.timestamps
    end
  end
end
