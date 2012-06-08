require 'sinatra/base'

module Hermes
  class Frontend < Sinatra::Base
    before do
      begin
        @website = Domain.find(uri).website
      rescue
        halt 404, "Website with domain `#{uri}` not found."
      end
    end

    get %r{^.+$} do
      resource = Resource.where(:uri => request.path, :website_id => @website.id).first
      case resource.asset.class
      when Asset::Static
        status        200
        content_type  resource.asset.file.content_type
        body          resource.asset.file.read
      end
    end
  end
end

# require 'mongo' 
# class GridfsController < ActionController::Metal
#   def serve
#     gridfs_path = env["PATH_INFO"].gsub("/images/", "")
#     begin
#       gridfs_file = Mongo::GridFileSystem.new(Mongoid.database).open(gridfs_path, 'r')
#       self.response_body = gridfs_file.read
#       self.content_type = gridfs_file.content_type
#     rescue
#       self.status = :file_not_found
#       self.content_type = 'text/plain'
#       self.response_body = ''
#     end
#   end
# end