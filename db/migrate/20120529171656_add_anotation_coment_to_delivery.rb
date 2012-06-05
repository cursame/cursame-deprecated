class AddAnotationComentToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :anotation_coment, :text
  end
end
