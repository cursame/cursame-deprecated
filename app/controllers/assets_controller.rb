class AssetsController < ApplicationController
  def upload
    asset_file = Asset.new :file => uploaded_file
    as_json = asset_file.as_json(:methods => [:file_cache], :only => [:file_cache]).merge(:file => asset_file.file.to_hash)
    
    render :json => as_json
  end
end
