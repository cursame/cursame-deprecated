class SendReport < ActiveRecord::Base
  belongs_to :user
  has_many :bug_answers
  
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :event_date

end
