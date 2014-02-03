class AddSudoAuthToServer < ActiveRecord::Migration
  def change
    add_column :servers, :can_sudo, :boolean
    add_column :servers, :sudo_password, :string
  end
end
