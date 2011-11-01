class RegistrationsController < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash ||= params[resource_name] || {}
    self.resource    = resource_class.new_with_session(hash, session)
    resource.networks << current_network 
    resource.role    = role
  end

  protected
  def role
    resource_name.to_s.gsub('_user', '')
  end
end
