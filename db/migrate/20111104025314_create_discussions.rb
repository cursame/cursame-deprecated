class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.references :course
      t.references :user
      t.string     :title
      t.text       :description
      t.timestamps
    end
  end
end
