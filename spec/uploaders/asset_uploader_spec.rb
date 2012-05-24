require 'spec_helper'

describe AssetUploader do
  let(:model)     { double("model") }
  let(:uploader)  { AssetUploader.new(model, :asset) }
  
  before do
    AssetUploader.enable_processing = true 
  end
  
  after do
    AssetUploader.enable_processing = false
  end
  
  it "should set the filename to the file md5 hash" do
    uploader.store! upload(:jpg)
    uploader.filename.should == "#{Digest::MD5.hexdigest(uploader.read)}.jpg"
  end
  
  describe "validations" do
    it "should only accept images" do
      uploader.extension_white_list.should =~ %w(jpg jpeg gif png swf pdf doc docx xls xlsx txt)
    end
  end
end