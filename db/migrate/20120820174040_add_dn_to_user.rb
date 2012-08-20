class AddDnToUser < ActiveRecord::Migration
  def change
    add_column :users, :dn, :integer
  end
end
