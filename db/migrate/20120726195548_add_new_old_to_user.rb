class AddNewOldToUser < ActiveRecord::Migration
  def change
    add_column :users, :new_old, :integer, :default => 1
  end
end
