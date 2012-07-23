class AddDeliveryIdToCalificationem < ActiveRecord::Migration
  def change
    add_column :calificationems, :delivery_id, :integer
  end
end
