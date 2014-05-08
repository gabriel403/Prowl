class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :access_code

      t.timestamps
    end
    add_index :organisations, :access_code, unique: true
  end
end
