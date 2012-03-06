class AddPublicRegistryToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :public_registry, :boolean, :default => true
  end
end
