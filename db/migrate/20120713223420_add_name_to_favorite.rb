class AddNameToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites, :name, :string
  end
end
