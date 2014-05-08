class CreateDeployStepTypes < ActiveRecord::Migration
  def change
    create_table :deploy_step_types do |t|
      t.string :name
      t.string :subtype

      t.timestamps
    end
    add_index :deploy_step_types, :name, unique: true
  end
end
