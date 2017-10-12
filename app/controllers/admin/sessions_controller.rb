class Admin::SessionsController < Devise::SessionsController

  before_action :authenticate_admin!, except: [:new,:create]
 
  layout 'admin'

  # GET /resource/sign_in
   def new
     super
   end

  # POST /resource/sign_in
   def create
   	  self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: '/admin'   
   end

  # DELETE /resource/sign_out
   def destroy
    reset_session
    redirect_to '/admins/sign_in'
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
   end
end
