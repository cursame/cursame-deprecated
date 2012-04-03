# encoding: utf-8

class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  def store_dir
    "uploads/network_logo/#{model.id}"
  end

  version :large do
    process :resize_to_limit => [640, 175]
  end
  
  version :thumb do
    process :resize_to_limit => [250, 100]
  end

  version :small do
    process :resize_to_fit => [180, 180]
  end
  
  version :xsmall do
    process :resize_to_fit => [40, 40]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
