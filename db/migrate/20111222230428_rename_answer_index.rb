class RenameAnswerIndex < ActiveRecord::Migration
  def up
    rename_column :answers, :index, :position
  end

  def down
    rename_column :answers, :position, :index
  end
end
