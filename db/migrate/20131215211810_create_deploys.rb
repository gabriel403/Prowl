class CreateDeploys < ActiveRecord::Migration
  def change
    create_table :deploys do |t|
      t.boolean :success
      t.text :output
      t.references :app, index: true

      t.timestamps
    end
  end
end
