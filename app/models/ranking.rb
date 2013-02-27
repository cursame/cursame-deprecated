class Ranking < ActiveRecord::Base
  belongs_to :user
  belongs_to :top_user
end
