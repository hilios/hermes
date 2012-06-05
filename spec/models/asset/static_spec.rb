require 'spec_helper'

describe Asset::Static do
  # before  { config.storage = :grid_fs } # Allow grid_fs for now
  # after   { config.storage = :file    }

  let(:jpg)   { upload(:jpg) }
  let(:image) { FactoryGirl.build(:asset_static, :content => jpg) }
  
  describe "collection" do
    it { should have_field(:content) } # It is a String but not until Carrierwave process
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  specify { FactoryGirl.build(:image).should be_valid }

  describe "#set_urn" do
    it "sets the urn with uploaded filename" do
      image.set_urn
      image.urn.should == File.basename(jpg)
    end
  end

  describe "#file" do
    it "returns the mongoid " do
      pending
      resource = FactoryGirl.create(:image, :asset => image)
      resource.asset.file
    end
  end
end
