require 'sinatra/base'

module Hermes
  class Frontend < Sinatra::Base
    before do
      begin
        @website = Domain.find(uri).website
      rescue
        halt 404, "Website `#{uri}` not found."
      end
    end

    get %r{^.+$} do
      begin
        resource = Resource.where(:uri => request.path, :website_id => @website.id).first
        case resource.asset.class
        when Asset::Static
          status        200
          content_type  resource.asset.file.content_type
          body          resource.asset.file.read
        end
      rescue
        halt 404, "Resource `#{uri}` not found."
      end
    end
  end
end