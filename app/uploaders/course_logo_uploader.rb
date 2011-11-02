# encoding: utf-8

class CourseLogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :thumb do
    process :resize_to_fit => [250, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
