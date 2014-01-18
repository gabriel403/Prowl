class CreateDeploys < ActiveRecord::Migration
  def change
    create_table :deploys do |t|
      t.string :status, default: 'pending'
      t.text :output, default: ''
      t.references :app, index: true
      t.references :server

      t.timestamps
    end
  end
end
