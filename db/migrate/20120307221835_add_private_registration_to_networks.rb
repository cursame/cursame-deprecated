class AddPrivateRegistrationToNetworks < ActiveRecord::Migration
  def change
    add_column :networks, :private_registry, :boolean, :default => false
    add_column :networks, :registry_domain, :string
  end
end
