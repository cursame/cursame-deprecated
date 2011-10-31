class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :subodmain
      t.string :name
      t.timestamps
    end
  end
end
