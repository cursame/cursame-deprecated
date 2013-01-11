class AddIndextoActions < ActiveRecord::Migration
  def up
    add_index :actions, :user_id
    add_index :actions, :action
    add_index :actions, :created_at
  end

  def down
    remove_index :actions, :column => :user_id
    remove_index :actions, :column => :action
    remove_index :actions, :column => :created_at
  end
end
