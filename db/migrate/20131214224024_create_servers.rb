class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :host
      t.boolean :enabled

      t.timestamps
    end
  end
end
