class AddIpAdressToActions < ActiveRecord::Migration
  def change
    add_column :actions, :ip_adress, :string
  end
end
