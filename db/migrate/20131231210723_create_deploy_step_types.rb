class CreateDeployStepTypes < ActiveRecord::Migration
  def change
    create_table :deploy_step_types do |t|
      t.string :name
      t.string :subtype, :default => :generic
    end
  end
end
