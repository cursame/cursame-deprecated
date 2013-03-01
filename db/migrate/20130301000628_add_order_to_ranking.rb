class AddOrderToRanking < ActiveRecord::Migration
  def change
    add_column :rankings, :order, :integer
  end
end
