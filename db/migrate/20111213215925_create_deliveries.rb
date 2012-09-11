class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.text :content
      t.references :assignment
      t.references :user
      t.timestamps
    end
  end
end
