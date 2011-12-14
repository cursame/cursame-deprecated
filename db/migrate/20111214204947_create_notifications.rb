class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :notificator, :polymorphic => true
      t.references :user
      t.text :message
      t.timestamps
    end
  end
end
