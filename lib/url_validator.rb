# http://intridea.com/posts/quick-tip-url-validation-in-rails
require 'uri'
module ActiveModel
  module Validations
    class UrlValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        begin
          # Parse the uri to find errors, without the wildcards
          uri = URI.parse(value.gsub(/\.?\*\.?/, ''))
          # Looks like an URI
          r = value =~ URI::regexp(%w(http https))
          # Not allow blank hosts
          r &&= !uri.host.blank?
        rescue Exception => e   
          r = false
        end
        record.errors[attribute] << (options[:message] || "is invalid") unless r
      end
    end
  end
end