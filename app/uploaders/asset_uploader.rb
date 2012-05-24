# encoding: utf-8
class AssetUploader < CarrierWave::Uploader::Base
  # https://github.com/jnicklas/carrierwave#setting-the-content-type
  include CarrierWave::MimeTypes

  process :set_content_type
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png swf pdf doc docx xls xlsx txt)
  end

  # Override the filename of the uploaded files with md5 hash
  def filename
    "#{Digest::MD5.hexdigest(file.read)}.jpg" if original_filename
  end
end
