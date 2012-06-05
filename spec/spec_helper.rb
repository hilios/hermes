require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rack/test'
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'
  
  # Require the sinatra app
  require Rails.root.join("app/frontend")
  # Set sinatra environment
  Hermes::Frontend.set :environment, :test

  # Configure carrierwave for test environment
  CarrierWave.configure do |config|
    # No mather what use the file system
    # config.storage = :file
    # It's faster if you don't process images when you don't need
    config.enable_processing = false
  end
  # Upload everything to the spec/support/tmp/ folder
  CarrierWave.root = Rails.root.join('spec/support/tmp/').to_s

  RSpec.configure do |config|
    # Include CarrierWave matchers
    config.include CarrierWave::Test::Matchers
    # Include Mogoid matchers
    config.include Mongoid::Matchers
    # Rack Test methods
    config.include Rack::Test::Methods

    config.before(:suite) do
      DatabaseCleaner.orm      = :mongoid
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.after(:suite) do
      FileUtils.rm_rf(CarrierWave.root) # Erase the uploaded files in tests
    end

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| load f}

  # load Rails.root.join("app/frontend")
end