class AddAssignationFieldsToEnrollment < ActiveRecord::Migration
  def change
    add_column :enrollments, :admin, :boolean
    add_column :enrollments, :role,  :string
  end
end
