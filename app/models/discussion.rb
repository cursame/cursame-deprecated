class Discussion < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  has_many :comments, :as => :commentable
  belongs_to :course

  validates_presence_of :title, :course

  can_haz_assets

  html_sanitized :description
end
