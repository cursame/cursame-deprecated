# encoding: utf-8

class CourseLogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/course_logo/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [250, 100]
  end

  version :small do
    process :resize_to_fit => [180, 180]
  end
  
  version :xxsmall do
    process :resize_to_fill => [25, 25]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
