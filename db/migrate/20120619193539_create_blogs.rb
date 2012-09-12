class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :post
      t.text :content
      t.string :menu_category
      t.date :date

      t.timestamps
    end
  end
end
