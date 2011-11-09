class AssetsController < ApplicationController
  def upload
    asset_file = Asset.new :file => uploaded_file
    render :json => asset_file.as_json(:methods => [:file_cache], :only => [:file, :file_cache])
  end
end
