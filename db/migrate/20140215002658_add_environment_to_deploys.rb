class AddEnvironmentToDeploys < ActiveRecord::Migration
  def change
    add_reference :deploys, :environment, index: true
  end
end
