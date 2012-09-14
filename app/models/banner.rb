class Banner < ActiveRecord::Base
  mount_uploader :image_banner, BannerImageUploader
end
