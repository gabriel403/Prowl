class CreateAuthenticationTypes < ActiveRecord::Migration
  def change
    create_table :authentication_types do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end
