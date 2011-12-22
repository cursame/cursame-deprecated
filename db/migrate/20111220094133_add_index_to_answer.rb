class AddIndexToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :index, :integer
  end
end
