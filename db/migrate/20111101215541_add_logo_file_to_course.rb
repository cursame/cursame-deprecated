class AddLogoFileToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :logo_file, :string
  end
end
