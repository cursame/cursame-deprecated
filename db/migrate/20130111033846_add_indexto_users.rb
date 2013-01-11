class AddIndextoUsers < ActiveRecord::Migration
  def up
    add_index :users, :telefonica_role
    add_index :users, :telefonica_zone
  end

  def down
    remove_index :users, :column => :telefonica_zone
    remove_index :users, :column => :telefonica_role
  end
end
