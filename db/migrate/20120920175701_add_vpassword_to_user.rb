class AddVpasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :vpassword, :string
  end
end
