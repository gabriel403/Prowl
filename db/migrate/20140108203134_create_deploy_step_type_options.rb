class CreateDeployStepTypeOptions < ActiveRecord::Migration
  def change
    create_table :deploy_step_type_options do |t|
      t.string :name
      t.references :deploy_step_type, index: true
    end
  end
end
