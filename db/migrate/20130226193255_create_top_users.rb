class CreateTopUsers < ActiveRecord::Migration
  def change
    create_table :top_users do |t|
      t.string :name

      t.timestamps
    end
  end
end
