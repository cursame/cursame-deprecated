class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :user_id
      t.string :action
      t.string :user_agent
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
