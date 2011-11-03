class AssetsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def upload
    asset_file = Asset.new :file => uploaded_file
    render :json => asset_file.as_json(:methods => [:file_cache], :only => [:file, :file_cache])
  end
end
