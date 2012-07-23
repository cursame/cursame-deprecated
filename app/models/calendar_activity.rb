class CalendarActivity < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :name, :description, :due_to 
  
  def icon
     'menu-calendario.png'
  end
end
