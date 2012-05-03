# This file is used by Rack-based servers to start the application.

map '/admin' do
  require ::File.expand_path('../config/environment',  __FILE__)
  run Hermes::Application
end

map '/' do
  require ::File.expand_path('../config/sinatra',  __FILE__)
  run Hermes::Frontend
end