class CreateDeploys < ActiveRecord::Migration
  def change
    create_table :deploys do |t|
      t.string :status
      t.text :output
      t.references :server, index: true
      t.references :env, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
