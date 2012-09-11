class CreateBugAnswers < ActiveRecord::Migration
  def change
    create_table :bug_answers do |t|
      t.text :container
      t.date :date

      t.timestamps
    end
  end
end
