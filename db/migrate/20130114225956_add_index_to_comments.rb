class AddIndexToComments < ActiveRecord::Migration
  def up
    add_index :comments, :user_id
    add_index :comments, :created_at
  end

  def down
    remove_index :comments, :column => :user_id
    remove_index :comments, :column => :created_at
  end
end
