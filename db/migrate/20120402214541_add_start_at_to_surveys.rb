class AddStartAtToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :start_at, :datetime
  end
end
