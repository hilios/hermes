module ApplicationHelper
  # Render the flash messages
  def flash_messages(only = nil)
    render 'layouts/flash_messages', only: only
  end
  # Create a link with confirmation message and method set to delete.
  #
  # Returns a link_to helper with options +:confirm+ and +:method+ setted,
  # you can override the default values setting the options hash.
  def link_to_destroy(*args, &block)
    arg_index = if block_given? then 1 else 2 end
    args[arg_index] ||= {}
    args[arg_index][:data] = {} unless args[arg_index].has_key? :data
    args[arg_index][:data][:confirm] = t(:are_you_sure, :default => 'Are you sure?') unless args[arg_index][:data].has_key? :confirm
    args[arg_index][:method]  = :delete unless args[arg_index].has_key? :method
    link_to(*args, &block)
  end
  # Returns true if matchs the current path
  def path_is?(path)
    request.path == path
  end

  # Returns true if matchs the current url
  def url_is?(url)
    request.url == url
  end

  # Returns true if matchs the current module name
  # For example:
  # 
  #   Admin::UsersController.index
  #   module_is?(:admin)            # => true
  #   module_is?('admin', 'other')  # => true
  #   
  #   PostsController.show
  #   module_is?(:admin)            # => false
  #
  # If a block is given yield with the first argument has the
  # result of the match. For example:
  #
  #   module_is?(:admin) do |boolean|
  #     if boolean
  #       # Do something when true
  #     else
  #       # And another when false
  #     end
  #   end
  def module_is?(*modules, &block)
    has_value = modules.map(&:to_s).include? params[:controller][/(.+)\//, 1]
    return block_given? ? yield(has_value) : has_value
  end

  # Returns true if matchs the current controller name
  # For example:
  # 
  #   UsersController.index
  #   controller_is?(:users)            # => true
  #   controller_is?('users', 'other')  # => true
  #   
  #   PostsController.show
  #   controller_is?(:users)            # => false
  #
  # If a block is given yield with the first argument has the
  # result of the match. For example:
  #
  #   controller_is?(:admin) do |boolean|
  #     if boolean
  #       # Do something when true
  #     else
  #       # And another when false
  #     end
  #   end
  def controller_is?(*controllers, &block)
    has_value = controllers.map(&:to_s).include? params[:controller]
    return block_given? ? yield(has_value) : has_value
  end

  # Returns true if matchs the current action name
  # For example:
  # 
  #   UsersController.index
  #   action_is?(:users)            # => true
  #   action_is?('users', 'other')  # => true
  #   
  #   PostsController.show
  #   action_is?(:users)            # => false
  #
  # If a block is given yield with the first argument has the
  # result of the match. For example:
  #
  #   action_is?(:admin) do |boolean|
  #     if boolean
  #       # Do something when true
  #     else
  #       # And another when false
  #     end
  #   end
  def action_is?(*actions, &block)
    has_value = actions.map(&:to_s).include? params[:action]
    return block_given? ? yield(has_value) : has_value
  end
end
