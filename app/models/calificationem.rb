class Calificationem < ActiveRecord::Base
  belongs_to :delivery
  
      validates_presence_of :raiting
      validates_presence_of :anotation_coment
      validates_presence_of :delivery_id
end
