class ChangeToPolymorphicAssetsOwner < ActiveRecord::Migration
  def change
    add_column :assets, :owner_id,   :integer
    add_column :assets, :owner_type, :string
    remove_column :assets, :course_id
  end
end
