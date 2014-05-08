class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.references :organisation, index: true
      t.string :name
      t.string :host
      t.integer :port
      t.string :username
      t.references :authentication_type, index: true
      t.text :authentication
      t.boolean :enabled
      t.boolean :can_sudo
      t.string :sudo_password

      t.timestamps
    end
  end
end
