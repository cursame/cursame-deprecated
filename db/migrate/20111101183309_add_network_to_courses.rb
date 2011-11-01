class AddNetworkToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :network_id, :integer
    add_index  :courses, :network_id
  end
end
