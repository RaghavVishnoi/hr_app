class GeneralController < ApplicationController
  layout 'user'
  skip_before_filter :authenticate_employee!
  def index
  end

  def about
  end

  def contact
  end
end
