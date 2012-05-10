module NestedFormsHelper
  def render_nested_fields_form(form, association)
    model_object = begin
      form.object.class.reflect_on_association(association).klass.new
    rescue
      raise "Association #{association} not found"
    end
    form.fields_for(association, model_object, :child_index => "new_#{association}") do |association_form|
      render(association.to_s.singularize + "_fields", :f => association_form)
    end
  end
  
  def link_to_add_fields(*args, &block)
    options     = args.extract_options!.symbolize_keys
    association = args.pop
    form        = args.pop
    
    # Build the associated form
    nested_fields_form = render_nested_fields_form(form, association)
    # Set the options
    options[:class] = [options[:class], "add_nested_fields"].compact.join(" ")
    options["data-association"] = association
    options["data-nested"] = 'add'
    options["data-fields"] = nested_fields_form.gsub(/\"/, '\'')
    args << (options.delete(:href) || "#")
    args << options
    # Render the link
    link_to(*args, &block)
  end
  
  def link_to_remove_fields(*args, &block)
    options = args.extract_options!.symbolize_keys
    options[:class] = [options[:class], "remove_nested_fields"].compact.join(" ")
    options["data-nested"] = 'remove'
    form = args.pop
    args << (options.delete(:href) || "#")
    args << options
    form.hidden_field(:_destroy) + link_to(*args, &block)
  end
  
  module Mixin
    def nested_fields_for(association_name, *args)
      output = %Q[<div data-association="#{association_name}_fields">].html_safe
      output << fields_for(association_name, *args) do |association_form|
        @template.render(:partial => "#{association_name.to_s.singularize}_fields", :locals => {:f => association_form})
      end
      output.safe_concat('</div>')
      output
    end
    
    def link_to_add(*args, &block)
      options     = args.extract_options!.symbolize_keys
      association = args.pop
      args << self << association << options
      @template.link_to_add_fields(*args, &block)
    end
    
    def link_to_remove(*args, &block)
      options     = args.extract_options!.symbolize_keys
      args << self << options
      @template.link_to_remove_fields(*args, &block)
    end
  end
end

module SimpleForm
  class FormBuilder
    include ::NestedFormsHelper::Mixin
  end
end

module ActionView
  module Helpers
    module FormHelper 
      include ::NestedFormsHelper::Mixin
    end
  end
end