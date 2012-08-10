require 'spec_helper'

describe Asset::Static do
  # before  { config.storage = :grid_fs } # Allow grid_fs for now
  # after   { config.storage = :file    }

  let(:jpg)   { upload(:jpg) }
  let(:image) { FactoryGirl.build(:asset_static, content: jpg) }
  
  describe "collection" do
    it { should have_field(:content) } # It is a String but not until Carrierwave process
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  specify { FactoryGirl.build(:image).should be_valid }

  describe "#set_name" do
    it "sets the urn with uploaded filename" do
      image.set_name
      image.name.should == File.basename(jpg)
    end
  end

  describe "#file" do
    it "returns the mongoid gridfs item" do
      resource = FactoryGirl.create(:image, asset: image)
      resource.asset.file.should be_a(Mongo::GridIO)
      resource.asset.file.content_type.should == MIME::Types.type_for(image.content.to_s).first
      Digest::MD5.hexdigest(resource.asset.file.read).should == Digest::MD5.hexdigest(jpg.read)
    end
  end
end
