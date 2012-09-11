class AddUserNameToChat < ActiveRecord::Migration
  def change
    add_column :chats, :user_name, :string
  end
end
