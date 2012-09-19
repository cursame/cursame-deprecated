# encoding: utf-8

class BannerImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/banner_image/#{model.id}"
  end
  
  version :banner do
   process :resize_to_fit => [180, 170]
  end
  
  version :medium do 
    process :resize_to_fit => [80, 70]
  end
  
  version :micro do
    process :resize_to_fit => [50, 40]
  end
  
  
  # storage :fog
  def default_url 
     "/assets/#{model.title}_#{version_name}.png"
   end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:


end
