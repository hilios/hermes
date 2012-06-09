class ApplicationController < ActionController::Base
  protect_from_forgery
  
  respond_to :html

  before_filter :authenticate_user!
  
  layout :layout_by_resource

  def current_website
    if params[:website_id] or session[:current_website_id]
      @current_website ||= Website.find(params[:website_id] || session[:current_website_id])
    else
      @current_website ||= Domain.find(request.original_url).website rescue nil
    end
    
    if @current_website
      session[:current_website_id] = @current_website.id
      @current_website
    end
  end
  helper_method :current_website

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
