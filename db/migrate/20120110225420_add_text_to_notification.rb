class AddTextToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :text, :text
  end
end
