class ResourcesController < ApplicationController
  before_filter :load_website
  before_filter :load_asset, :except => :index

  # GET /resources
  # GET /resources.xml
  def index
    @resources = Resource.all
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

  private 

  def load_website
    @website = current_website
  end

  def load_asset
    # Ensure the asset class exists, if not raises a NameError and render a 404
    # @asset = Resources.const_get("#{params[:asset]}_asset".camelize.to_sym)
  rescue NameError
    # raise ActionController::RoutingError.new('Not Found')
    raise AbstractController::ActionNotFound
  end
end
