class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :finish_date
      t.boolean :public
      t.string :reference

      t.timestamps
    end
  end
end
