class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource({})
    render_with_scope :new
  end

  def update
    updated = params[resource_name][:password_changed] ? resource.update_with_password(params[resource_name]) : resource.update_attributes(params[resource_name])

    if updated
      set_flash_message :notice, :updated
      sign_in resource_name, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end
end
