# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  def store_dir
    "uploads/user_avatar/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [250, 100]
  end

  version :small do
    process :resize_to_fit => [180, 180]
  end
  
  version :xsmall do
    process :resize_to_fill => [40, 40]
  end
  
  version :xxsmall do
    process :resize_to_fill => [25, 25]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url 
    "/assets/#{model.role}_#{version_name}.png"
  end 
end
