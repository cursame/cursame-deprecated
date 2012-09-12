class AddAvatarToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_file, :string
  end
end
