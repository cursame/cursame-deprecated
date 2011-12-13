class AddFieldsToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :slogan, :string
    add_column :networks, :welcome_message, :string
    add_column :networks, :logo_file, :string
    add_column :networks, :time_zone, :string
  end
end
