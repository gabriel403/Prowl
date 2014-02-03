class AddDefaultValueToHasSudo < ActiveRecord::Migration
  def up
      change_column :servers, :can_sudo, :boolean, :default => false
      Server.where(can_sudo: nil).update_all(can_sudo: false)
  end

  def down
      change_column :servers, :can_sudo, :boolean, :default => nil
  end
end
