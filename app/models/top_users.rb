class TopUsers < ActiveRecord::Base
  has_many :rankings
  has_many :users, :through => :rankings

  def user_name
    name.try(:last_name)
  end
  def user_name=(name)
    self.name = User.find_by_last_name(name) if last_name.present?
  end
end
