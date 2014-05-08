class CreateOrganisationUsers < ActiveRecord::Migration
  def change
    create_table :organisation_users do |t|
      t.references :user, index: true
      t.references :organisation, index: true
      t.references :access_level, index: true

      t.timestamps
    end
  end
end
