class AddUserIdToAllDeploy < ActiveRecord::Migration
  def up
    execute "UPDATE deploys SET user_id = 1"
  end

  def down
    # not implemented
  end
end
