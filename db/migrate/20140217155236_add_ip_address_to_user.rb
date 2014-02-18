class AddIpAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :ip_address, :integer
  end
end
