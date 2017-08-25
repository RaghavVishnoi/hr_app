class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate_employee!

  def after_sign_in_path_for(resource)	
    dashboard_path
  end

end
