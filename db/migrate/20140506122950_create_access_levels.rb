class CreateAccessLevels < ActiveRecord::Migration
  def change
    create_table :access_levels do |t|
      t.string :name
      t.string :value
      t.string :access_type

      t.timestamps
    end
  end
end
