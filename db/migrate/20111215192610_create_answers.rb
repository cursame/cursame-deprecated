class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers, :id => false do |t|
      t.string :uuid, :limit => 36, :primary => true
      t.references    :question
      t.string        :text
      t.timestamps
    end
  end
end
