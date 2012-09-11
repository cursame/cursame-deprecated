class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :notificator, :polymorphic => true
      t.references :user
      t.string     :kind
      t.timestamps
    end
  end
end
