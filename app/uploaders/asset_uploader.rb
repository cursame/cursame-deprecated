# encoding: utf-8

class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  process :set_content_type

  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end
end
