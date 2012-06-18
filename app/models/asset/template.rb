module Asset
  class Template < Base
    include Mongoid::Document
    include Mongoid::Versioning
    include Mongoid::Timestamps

    field :content,   :type => String

    embeds_many :variables, :class_name => Asset::TemplateVariable.name
  end
end