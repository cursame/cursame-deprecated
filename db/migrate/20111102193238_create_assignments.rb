class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string     :name
      t.references :course
      t.text       :description
      t.integer    :value
      t.integer    :period

      t.timestamps
    end
  end
end
