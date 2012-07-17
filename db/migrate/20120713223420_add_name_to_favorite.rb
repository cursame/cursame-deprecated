class AddNameToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites_users, :name, :string
  end
end
