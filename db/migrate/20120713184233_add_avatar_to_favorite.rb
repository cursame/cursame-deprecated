class AddAvatarToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites, :avatar, :string
  end
end
