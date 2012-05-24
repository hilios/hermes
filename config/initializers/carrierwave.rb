# https://github.com/jnicklas/carrierwave#setting-the-content-type
require 'carrierwave/processing/mime_types'

CarrierWave.configure do |config|
  config.grid_fs_database = Mongoid.database.name
  config.grid_fs_host     = Mongoid.config.master.connection.host
  config.storage :grid_fs
  # config.grid_fs_access_url = "/image/show"
end