class CreateAuthenticationTypes < ActiveRecord::Migration
  def change
    create_table :authentication_types do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end

    # populate the table
    AuthenticationType.create :name => "Password", :short_name => "password"
    AuthenticationType.create :name => "Key Pair [file]", :short_name => "keyfile"
    AuthenticationType.create :name => "Key Pair [stored]", :short_name => "keystored"
  end
end
