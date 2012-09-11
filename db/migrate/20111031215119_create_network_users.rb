class CreateNetworkUsers < ActiveRecord::Migration
  def up
    create_table :networks_users, :id => false do |t|
      t.references :network
      t.references :user
    end

    add_index :networks_users, :network_id
    add_index :networks_users, :user_id
  end

  def down
    drop_table :networks_users
  end
end
