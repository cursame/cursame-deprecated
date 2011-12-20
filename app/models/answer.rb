class Answer < ActiveRecord::Base
  belongs_to :question
  set_primary_key :uuid

  after_initialize do |answer|
    answer.uuid ||= UUID.new.generate
  end

  validates_presence_of :text, :index
  validates_uniqueness_of :index, :scope => :question_id
end
