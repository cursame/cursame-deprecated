class AddStateToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :state, :string
  end
end
