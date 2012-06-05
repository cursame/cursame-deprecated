class AddRaitingToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :raiting, :integer
  end
end
