class LowercaseDeployStatus < ActiveRecord::Migration
  def self.up
    execute "UPDATE deploys SET status = lower(status)"
  end

  def self.down
    # not implemented
  end
end
