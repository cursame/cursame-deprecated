class CourseAsset < ActiveRecord::Base
  belongs_to :course
  mount_uploader :file, CourseAssetUploader
end
