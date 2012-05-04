module ApplicationHelper
  # Render the flash messages
  def flash_messages(only = nil)
    render 'layouts/flash_messages', only: only
  end
end
