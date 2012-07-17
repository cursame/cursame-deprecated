class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites_users do |t|
      t.integer :user_id
      t.integer :user_favorite_id

      t.timestamps
    end
  end
end
