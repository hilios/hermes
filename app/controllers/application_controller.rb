class ApplicationController < ActionController::Base
  protect_from_forgery
  
  respond_to :html

  before_filter :authenticate_user!
  
  layout :layout_by_resource

  def current_website
    @current_website ||= if session[:current_website_id]
      Website.find(session[:current_website_id])
    else
      Domain.find(request.original_url).website rescue nil
    end
    current_website = @current_website
    @current_website
  end
  helper_method :current_website

  def current_website=(website)
    session[:current_website_id] = website.id
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
