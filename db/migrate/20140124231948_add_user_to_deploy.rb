class AddUserToDeploy < ActiveRecord::Migration
  def change
    add_reference :deploys, :user, index: true
  end
end
