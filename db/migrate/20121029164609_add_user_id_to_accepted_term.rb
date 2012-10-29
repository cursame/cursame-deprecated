class AddUserIdToAcceptedTerm < ActiveRecord::Migration
  def change
    add_column :accepted_terms, :user_id, :integer
  end
end
