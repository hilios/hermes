require 'spec_helper'

describe AssetUploader do
  let(:model)     { FactoryGirl.create(:image).asset }
  let(:uploader)  { AssetUploader.new(model, :asset) }
  
  before do
    AssetUploader.enable_processing = true 
  end
  
  after do
    AssetUploader.enable_processing = false
  end
  
  it "sets the filename with the file md5 checksum" do
    uploader.store! upload(:jpg)
    uploader.filename.should == "#{Digest::MD5.hexdigest(uploader.read)}.jpg"
  end

  it "stores the uploaded file under website.id/assets folder" do
    uploader.store_dir.should =~ Regexp.new(model.resource.website.id.to_s)
    uploader.store_dir.should =~ /assets/
  end
  
  describe "validations" do
    it "accepts images, flash, pdf, word, excel and txt files " do
      uploader.extension_white_list.should =~ %w(jpg jpeg gif png swf pdf doc docx xls xlsx txt)
    end
  end
end