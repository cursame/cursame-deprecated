class AddChatToUser < ActiveRecord::Migration
  def change
    add_column :users, :chat_id, :integer
  end
end
