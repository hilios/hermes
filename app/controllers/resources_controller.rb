class ResourcesController < ApplicationController
  before_filter :load_website, except: :manage

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
    @resource.asset = asset_type.new
    respond_with(@resource)
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
    respond_with(@resource)
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = Resource.new(params[:resource])
    @resource.website = @website
    @resource.save
    respond_with(@resource)
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = Resource.find(params[:id])
    @resource.update_attributes(params[:resource])
    respond_with(@resource)
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    respond_with(@resource)
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
    return redirect_to websites_path if @website.nil?
  end

  def asset_type
    @asset_type ||= params[:_type].constantize
  end
  helper_method :asset_type

end
