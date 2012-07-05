class AddStatusToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :status, :string
  end
end
