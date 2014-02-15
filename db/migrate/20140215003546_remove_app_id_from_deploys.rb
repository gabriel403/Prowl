class RemoveAppIdFromDeploys < ActiveRecord::Migration
  def change
    remove_column :deploys, :app_id, :int
  end
end
