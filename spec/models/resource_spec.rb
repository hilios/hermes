require 'spec_helper'

describe Resource do
  describe "collection" do
    it { should have_field(:uri).of_type(String) }
    
    describe "modules" do
      it { should have_field(:version).of_type(Integer) }
      it { should have_field(:created_at).of_type(Time) }
      it { should have_field(:updated_at).of_type(Time) }
    end

    describe "ancestry" do
      it { should have_field(:ancestry).of_type(String) }
    end
  end
  
  describe "relations" do
    it { should embed_one(:asset) }
    it { should belong_to(:website) }
  end

  describe "validations" do
    it { should validate_presence_of(:uri) }
    it { should validate_presence_of(:asset) }
    it { should validate_presence_of(:website) }
  end

  describe "mass assigment" do
    it { should_not allow_mass_assignment_of(:uri) }
  end

  describe "callbacks" do
    it "calls the #uri method before save" do
      Resource.any_instance.stub(:uri) { "/path/to/file" }
      Resource.any_instance.should_receive(:uri).at_least(:once)
      FactoryGirl.create(:resource)
    end
  end

  let(:folder)      { FactoryGirl.create(:folder)    }
  let(:sub_folder)  { FactoryGirl.create(:folder, :parent => folder)  }

  describe "#url" do
    it "returns a slash if is root" do
      folder.url.should == "/"
    end

    it "returns a string with the parents uri with a slash at the end" do
      sub_folder.url.should =~ Regexp.new(sub_folder.parent.uri)
    end
  end

  describe "#uri" do
    it "builds the uri string with the parent " do
      folder.uri.should =~ Regexp.new(folder.url)
      folder.uri.should =~ Regexp.new(folder.urn)
    end
  end

  describe "#folder?" do
    it "returns true if asset is a folder false otherwise" do
      folder.folder?.should be_true
    end
  end
end
