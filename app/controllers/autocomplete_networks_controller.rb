class AutocompleteNetworksController < ApplicationController

  skip_before_filter :authenticate_active_user_within_network!, :only => [:index, :terms, :network_cc]

  def index
    @networks_hash = []
    @networks = Network.find :all

    @networks.each do |n|
       @networks_hash << { "label" => n.name, "value" => n.subdomain }
     end
 
     render :json => @networks_hash
  end

end
