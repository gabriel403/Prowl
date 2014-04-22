class AddPortToServer < ActiveRecord::Migration
  def change
    add_column :servers, :port, :integer, :default => 22, :after => :host
  end
end
