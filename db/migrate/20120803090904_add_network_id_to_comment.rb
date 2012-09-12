class AddNetworkIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :network_id, :integer
  end
end
