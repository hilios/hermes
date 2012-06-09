class ResourcesController < ApplicationController
  before_filter :load_website

  # GET /resources
  # GET /resources.xml
  def index
    @resources = @website.resources.all
    respond_with(@website, @resources)
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = Resource.find(params[:id])
    respond_with(@website, @resource)
  end

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = Resource.new
    @resource.asset = asset_class.new
    respond_with(@resource)
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
    respond_with(@website, @resource)
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = Resource.new(params[:resource])
    @resource.website = @website
    @resource.save
    respond_with(@website, @resource)
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = Resource.find(params[:id])
    @resource.update_attributes(params[:resource])
    respond_with(@website, @resource)
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    respond_with(@website, @resource)
  end
  
  # GET /preview
  def preview
    @resource = Resource.find(params[:id])
    case @resource.asset.class
    when Asset::Static
      send_data @resource.asset.file.read, 
        :type => @resource.asset.file.content_type, 
        :filename => @resource.asset.urn, 
        :disposition => 'inline'
    else
      render :file_not_found 
    end
  end

  private 

  def load_website
    @website = current_website
  end

  def asset_class
    # Ensure the asset class exists, if not raises a NameError and render a 404
    @asset ||= if params[:asset].present?
      eval("asset/#{params[:asset]}".camelize)
    elsif params[:resource].present? and params[:resource][:asset_attributes].present? and 
          params[:resource][:asset_attributes][:_type].present?
      eval(params[:resource][:asset_attributes][:_type])
    else
      @resource.asset.class
    end
  rescue NameError
    raise ActionController::RoutingError.new("#{"asset/#{params[:asset]}".camelize.to_sym} does not exists!")
  end
  
  def asset_type
    asset_class.name.to_s
  end
  helper_method :asset_type
end
