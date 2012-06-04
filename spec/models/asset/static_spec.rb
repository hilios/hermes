require 'spec_helper'

describe Asset::Static do
  let(:jpg)       { upload(:jpg) }
  let(:image)     { FactoryGirl.build(:asset_static, :content => jpg) }
  
  describe "collection" do
    it { should have_field(:content_type).of_type(String) }
    it { should have_field(:content) } # It is a String but not until Carrierwave process
  end

  describe "validations" do
    it { should validate_presence_of(:content_type) }
    it { should validate_presence_of(:content) }
  end

  specify { FactoryGirl.build(:image).should be_valid }

  describe "#content=" do
    it "sets the urn with uploaded filename" do
      image.urn.should == File.basename(jpg)
    end

    it "sets the content_type with uploaded type" do
      MIME::Types.type_for(jpg.path).should include(image.content_type)
    end
  end
end
