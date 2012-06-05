require 'spec_helper'

describe Asset::Static do
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
end
