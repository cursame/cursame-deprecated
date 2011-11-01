class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates_inclusion_of :state, :in => %w(pending rejected accepted)

  def pending?
    state == 'pending'
  end

  def rejected?
    state == 'rejected'
  end

  def accepted?
    state == 'accepted'
  end
end
