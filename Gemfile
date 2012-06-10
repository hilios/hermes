source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'sqlite3'
gem 'mongoid'                               # NoSQL database
gem 'bson_ext'                              # A faster bson encoder
gem 'unicorn'                               # Unicorn server
gem 'mongoid-ancestry'                      # Tree structure with materialised path pattern for mongoid
gem 'haml-rails'                            # HAML for templates
gem 'coffee-filter'                         # Enable to write coffeescript inside views
gem 'jquery-rails'                          # JavaScript can be easier
gem 'responders'                            # DRY flash messages and more
gem 'devise', '2.0.0.rc'                    # User authentication
gem 'omniauth'                              # Apps authentication (required by devise installation)
gem 'moulin_rouge'                          # Better organization authorization through CanCan
gem 'simple_form', '>= 2.0.0'               # Simplificate the forms layouts
gem 'crummy', '~> 1.5.0'                    # Breadcrumbs
gem 'kaminari'                              # Pagination
gem 'ransack'                               # Hanlde search (including forms)
gem 'carrierwave'                           # Handle uploaded files
gem 'carrierwave-mongoid',                  # Support for Mongoid
  require: 'carrierwave/mongoid'
gem 'mini_magick'                           # Image processor
gem 'rest-client'                           # A REST client

gem 'sinatra'                               # Faster access for the frontend

group :assets do
  gem 'less-rails-bootstrap'                # THE Layout
  # gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'            # Make JavaScript easier to write
  gem 'therubyracer', platform: :ruby       # JavaScript evaluation
  gem 'uglifier', '>= 1.0.3'                # Assets compressor
end

group :development do
  gem 'capistrano'                          # Deploy com Capistrano: cap deploy
  gem 'rvm-capistrano'                      # Receitas do RVM para o Capistrano
  gem 'capistrano_colors'                   # Ouput colorido para o Capistrano
  gem 'capistrano-unicorn'                  # Receitas do Unicorn para o Capistrano
  gem 'rdoc'                                # Documentação
end

group :test do
  gem 'launchy'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'rspec-rails'
  gem 'email_spec'
  gem 'mongoid-rspec'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  # Test environment
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-spork'
  gem 'guard-rspec'
  # Pretty printed test output
  # gem 'turn', :require => false
end