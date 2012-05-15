class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :user 
      t.string :text
      t.time :time

      t.timestamps
    end
  end
end
