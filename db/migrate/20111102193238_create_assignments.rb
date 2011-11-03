class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :course
      t.string     :name
      t.text       :description
      t.integer    :value
      t.integer    :period
      t.datetime   :due_to

      t.timestamps
    end
  end
end
