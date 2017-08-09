class HomeController < ApplicationController
  layout 'user'
  skip_before_filter :authenticate_employee!

  def index
  end

end
