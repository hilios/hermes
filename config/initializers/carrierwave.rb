CarrierWave.configure do |config|
  # Mongoid::Config.database.name
  config.grid_fs_database = "#{Mongoid::Config.database.name}_uploads"

  # Mongoid::Config.database.connection.primary.join(':') # => localhost:27017 in most cases
  # config.grid_fs_host     = 'mongo.example.com'
  
  # config.grid_fs_access_url = "/image/show"

  config.storage :grid_fs
end