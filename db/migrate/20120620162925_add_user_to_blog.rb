class AddUserToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :user, :string
  end
end
