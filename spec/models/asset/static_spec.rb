require 'spec_helper'

describe Asset::Static do
  describe "collection" do
    it { should have_field(:content) } # It is a String but not until Carrierwave process
  end
  
  let(:jpg)       { upload(:jpg) }
  let(:image)     { FactoryGirl.build(:asset_static, :content => jpg) }
  let(:resource)  { FactoryGirl.create(:image) }
  
  describe "callbacks" do
    context "before create" do
      it "calls assign urn" do
        Asset::Static.any_instance.should_receive(:assign_urn).at_least(:once)
        resource # run
      end
    end
  end
  
  describe "#assign_urn" do
    it "sets the urn with uploaded filename" do
      image.assign_urn
      image.urn.should == File.basename(jpg)
    end
  end
  
  describe "#assign_content_type" do
    it "sets the content type from the uploaded file"
  end
end
