class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :user_favorite_id

      t.timestamps
    end
  end
  def self.up
          rename_table :favorites, :favorites_users
      end 
  def self.down
          rename_table :favorites, :favorites_users
  end
end
