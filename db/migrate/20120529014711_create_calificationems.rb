class CreateCalificationems < ActiveRecord::Migration
  def change
    #drop_table :calificationems
    create_table :calificationems do |t|
      t.integer :raiting
      t.text :anotation_coment

      t.timestamps
    end
  end
end
