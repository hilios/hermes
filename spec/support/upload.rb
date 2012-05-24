# Allow easy access to files
def upload(filename)
  filename = case filename
  when :jpg then 'picture.jpg'
  when :pdf then 'document.pdf'
  else filename
  end
  File.open(Rails.root.join('spec/support/files', filename))
end