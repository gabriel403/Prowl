class CreateDeployOptionTypes < ActiveRecord::Migration
  def change
    create_table :deploy_option_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
