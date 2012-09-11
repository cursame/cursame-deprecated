class CreateTutoriales < ActiveRecord::Migration
  def change
    create_table :tutoriales do |t|
      t.string :title
      t.text :description
      t.date :date
      t.string :link

      t.timestamps
    end
  end
end
