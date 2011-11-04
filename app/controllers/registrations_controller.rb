class RegistrationsController < Devise::RegistrationsController
  
  helper_method :role
  
  def build_resource(hash=nil)
    hash ||= params[resource_name] || {}
    self.resource    = resource_class.new_with_session(hash, session)
    resource.networks << current_network 
    resource.role    = role
    resource.state = resource.role == 'student' ? 'active' : 'inactive'
  end

  protected
  def role
    resource_name.to_s.gsub('_user', '')
  end
end
