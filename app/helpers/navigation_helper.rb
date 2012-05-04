module NavigationHelper
  # Returns an array with +'active'+ member if the condition given
  # is true. Use cases:
  #
  #   activate_if(true)   # => ['active']
  #   activate_if(false)  # => []
  #
  # Any other arguments will be appended to the given array
  # no matter if condition is true or false. For example:
  #
  #   activate_if(true, 'one', 'another') # => ['active', 'one', 'another']
  #   activate_if(false, 'one')           # => ['one']
  def activate_if(condition, *args)
    args << 'active' if condition
    args
  end
end