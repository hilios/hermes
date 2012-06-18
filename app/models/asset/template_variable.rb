module Asset
  class TemplateVariable
    include Mongoid::Document
    field :name, :type => String
    field :type, :type => Symbol
    field :allow_blank, :type => Boolean

    embedded_in :template

    validates :name,
      :presence => true,
      :format => {:with => /^(?!^\d)(?!.*\s)(?!.*[^a-zA-Z_0-9]).*$/}

    validates_presence_of :type

    def self.type_collection
      [:text, :rich_text, :number]
    end
  end
end
