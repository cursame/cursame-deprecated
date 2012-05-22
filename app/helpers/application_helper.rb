module ApplicationHelper
  def members_active
    if controller_name == "courses" && action_name == "members"
      "active"
    end
  end
  def broadcast(channel, &block)
      message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
      uri = URI.parse("http://cursatest.com/faye")
      Net::HTTP.post_form(uri, :message => message.to_json)
    end
end
