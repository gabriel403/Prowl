class CreateAppSetups < ActiveRecord::Migration
  def change
    create_table :app_setups do |t|
      t.string :name
      t.string :value

      t.timestamps
    end

    # populate the table
    AppSetup.create :name => "app_name", :value => "Prowl"
    AppSetup.create :name => "registrations_open", :value => 'true'
   end
end
