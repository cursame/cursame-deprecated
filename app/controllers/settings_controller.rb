class SettingsController < ApplicationController

  def show
  end

  def password
    # I'm not using if current_user.update_attributes(params[:user])
    # so that the admin can update his password. This would fail because
    # the role of the admin is not allowed by the User model.

    password      = params[:user][:password]
    password_conf = params[:user][:password_confirmation]

    if !password.blank? && password == password_conf
      current_user.password              = password
      current_user.password_confirmation = password
      current_user.save(:validate => false)

      redirect_to settings_path
    else
      render :show
    end
  end

end
