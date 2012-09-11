class AddVarianteToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :variante, :string, :default => "free"
  end
end
