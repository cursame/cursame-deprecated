class AddBussinesRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :bussines_role, :string
  end
end
