class FileSystemController < ApplicationController
  # GET /file_system
  # GET /file_system.xml
  def index
    @file_system = FileSystem.all
    respond_with(@file_system)
  end

  # GET /file_system/1
  # GET /file_system/1.xml
  def show
    @file_system = FileSystem.find(params[:id])
    respond_with(@file_system)
  end

  # GET /file_system/new
  # GET /file_system/new.xml
  def new
    @file_system = FileSystem.new
    respond_with(@file_system)
  end

  # GET /file_system/1/edit
  def edit
    @file_system = FileSystem.find(params[:id])
    respond_with(@file_system)
  end

  # POST /file_system
  # POST /file_system.xml
  def create
    @file_system = FileSystem.new(params[:file_system])
    @file_system.save
    respond_with(@file_system)
  end

  # PUT /file_system/1
  # PUT /file_system/1.xml
  def update
    @file_system = FileSystem.find(params[:id])
    @file_system.update_attributes(params[:file_system])
    respond_with(@file_system)
  end

  # DELETE /file_system/1
  # DELETE /file_system/1.xml
  def destroy
    @file_system = FileSystem.find(params[:id])
    @file_system.destroy
    respond_with(@file_system)
  end
end
