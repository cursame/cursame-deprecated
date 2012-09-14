# encoding: utf-8

class BannerImageUploader < CarrierWave::Uploader::Base

  #include CarrierWave::MiniMagick
  # Choose what kind of storage to use for this uploader:
  storage :file
  
   
  # storage :fog
  def default_url 
     "/assets/#{model.title}_#{version_name}.png"
   end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:


end
