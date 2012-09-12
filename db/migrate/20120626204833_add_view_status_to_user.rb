class AddViewStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :view_status, :string, :default => "live"
  end
end
