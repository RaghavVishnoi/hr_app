class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate_employee!
  before_filter :all_messages
  before_filter :last_url

  def after_sign_in_path_for(resource)	
    dashboard_path
  end

  def all_messages
    @messages = Message.order("id desc").first(5)
  end

  def last_url
    if request.referrer != nil
  	 Rails.application.routes.recognize_path(request.referrer)
    else
      ''
    end
  end

end
