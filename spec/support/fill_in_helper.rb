# Helper to set the domain url
def fill_in_url(options)
  find(:css, 'input[name$="[url]"]').set(options[:with])
end