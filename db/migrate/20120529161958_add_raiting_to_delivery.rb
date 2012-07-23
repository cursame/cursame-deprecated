class AddRaitingToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :raiting, :integer, :default => 0
  end
end
