class AddStartAtToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :start_at, :datetime
  end
end
