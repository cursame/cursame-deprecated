class AddAvatarToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites_users, :avatar, :string
  end
end
