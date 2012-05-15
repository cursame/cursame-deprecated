class AddChatIdToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :chat_id, :integer
  end
end
