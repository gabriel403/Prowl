class AddBranchOptionType < ActiveRecord::Migration
  def up
	   DeployOptionType.create! :name => "branch_name"
  end

  def down
    DeployOptionType.destroy_all(name: "branch_name")
  end
end
