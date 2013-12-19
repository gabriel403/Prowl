class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :host
      t.string :username
      t.references :authentication_type
      t.text :authentication
      t.references :user, index: true
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
