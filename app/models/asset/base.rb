module Asset
  class Base
    include Mongoid::Document
    field :urn, :type => String
    
    embedded_in :resource
    
    validates_presence_of :urn

    # Cast this class correctly
    # http://stackoverflow.com/questions/10033015/saving-updating-a-model-with-nested-attributes-and-single-table-inheritance
    class << self
      def new_with_cast(*attributes, &block)
        if (h = attributes.first).is_a?(Hash) && !h.nil? && (_type = h[:_type] || h['type']) && _type.length > 0 && (klass = _type.constantize) != self
          raise "wtF hax!!"  unless klass <= self
          return klass.new(*attributes, &block)
        end
        new_without_cast(*attributes, &block)
      end
      alias_method_chain :new, :cast
    end
  end
end