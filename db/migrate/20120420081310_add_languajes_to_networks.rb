class AddLanguajesToNetworks < ActiveRecord::Migration
  def change
    add_column :networks, :lenguajes, :string
  end
end
