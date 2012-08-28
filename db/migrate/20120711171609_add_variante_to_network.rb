class AddVarianteToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :variante, :string
  end
end
