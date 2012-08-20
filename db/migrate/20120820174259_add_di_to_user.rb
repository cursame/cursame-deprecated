class AddDiToUser < ActiveRecord::Migration
  def change
    add_column :users, :di, :string, :default => "a10"
  end
end
