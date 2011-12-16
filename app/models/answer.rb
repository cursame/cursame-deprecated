class Answer < ActiveRecord::Base
  belongs_to :question
  attr_protected :uuid

  after_initialize do |answer|
    answer.uuid ||= UUID.new.generate
  end

  validates_presence_of :text
end
