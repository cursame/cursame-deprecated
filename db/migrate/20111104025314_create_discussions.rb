class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.references :course
      t.string     :title
      t.text       :description
      t.timestamps
    end
  end
end
