class DropBannersTable < ActiveRecord::Migration
  def up
    
  end

  def down
    drop_table :banners
  end
end
