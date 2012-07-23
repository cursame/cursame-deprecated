class AddCalificationemIdToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :calificationem_id, :integer
  end
end
