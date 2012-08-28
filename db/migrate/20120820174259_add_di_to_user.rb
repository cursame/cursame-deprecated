class AddDiToUser < ActiveRecord::Migration
  def change
    add_column :users, :di, :string
  end
end
