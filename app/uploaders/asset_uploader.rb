# encoding: utf-8

class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  
  process :set_content_type

  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end
  
  def store_dir
    "uploads/asset/#{model.id}"
  end
  
  def thumb
    {:url => thumb_url}
  end

  def thumb_url
    case to_s
    when /\.jpg$/i, /\.png$/i, /\.tif$/i, /\.tiff$/i, /\.gif$/i,/\.ico$/i,/\.jpeg$/i
      '/assets/file_icons/image.png'
    when /\.xls$/i, /\.csv$/i,/\.sao$/i
      '/assets/file_icons/excel.png'
    when /\.doc$/i, /\.docx$/i,/\.odt$/i,/\.sxw$/i,/\.rtf$/i
      '/assets/file_icons/word.png'
    when /\.ade$/i, /\.adp$/i
      '/assets/file_icons/access.png'
    when /\.pdf/i
      '/assets/file_icons/pdf.png'
    when /\.swf$/i, /\.flv$/i
      '/assets/file_icons/page_white_flash.png'
    when /\.rar$/i,/\.zip$/i,/\.tar$/i,/\.targz$/i
      '/assets/file_icons/archive.png'
    when /\.dwg$/i,/\.dwf$/i
      '/assets/file_icons/cad.png'
    when /\.exe$/i,/\.dmg$/i
      '/assets/file_icons/exec.png'
    when /\.ppt$/i,/\.pptx$/i
      '/assets/file_icons/ppt.png'
    else
      '/assets/file_icons/text.png'
    end
  end

  def to_hash
    {:thumb => thumb, :url => url}
  end

end
