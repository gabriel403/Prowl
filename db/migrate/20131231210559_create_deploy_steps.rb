class CreateDeploySteps < ActiveRecord::Migration
  def change
    create_table :deploy_steps do |t|
      t.integer :order, :default => 0
      t.references :deploy_step_type_option, index: true
      t.string :value
      t.string :additional, :default => "[]"
      t.references :app

      t.timestamps
    end
  end
end
