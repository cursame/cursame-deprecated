class Answer < ActiveRecord::Base
  belongs_to :question

  after_initialize do |answer|
    answer.uuid ||= UUID.new.generate
  end

  validates_presence_of :text
end
