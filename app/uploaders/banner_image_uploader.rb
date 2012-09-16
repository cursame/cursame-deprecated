# encoding: utf-8

class BannerImageUploader < CarrierWave::Uploader::Base

  #include CarrierWave::MiniMagick
  # Choose what kind of storage to use for this uploader:
  def store_dir
    "uploads/banner_image/#{model.id}"
  end
  
   
  # storage :fog
  def default_url 
     "/assets/#{model.title}_banner_image.png"
   end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:


end
