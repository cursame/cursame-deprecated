class AddDnToUser < ActiveRecord::Migration
  def change
    add_column :users, :dn, :integer, :default => 0
  end
end
