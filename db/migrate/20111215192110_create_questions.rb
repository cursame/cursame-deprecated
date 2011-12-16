class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :survey
      t.string     :answer_uuid
      t.string     :text
      t.timestamps
    end
  end
end
