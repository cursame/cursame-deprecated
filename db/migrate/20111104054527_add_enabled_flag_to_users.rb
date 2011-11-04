class AddEnabledFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :state, :string, :default => 'active'
  end
end
