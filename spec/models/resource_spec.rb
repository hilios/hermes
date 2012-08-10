require 'spec_helper'

describe Resource do
  describe "collection" do
    it { should have_field(:path).of_type(String) }
    
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
    it { should validate_presence_of(:path) }
    it { should validate_uniqueness_of(:path) }

    it { should validate_presence_of(:asset) }
    it { should validate_presence_of(:website) }
  end

  describe "mass assigments" do
    it { should_not allow_mass_assignment_of(:path) }
  end

  describe "callbacks" do
    it "calls the #generate_path method before validation" do
      Resource.any_instance.stub(:generate_path) { "/path/to/file" }
      Resource.any_instance.should_receive(:generate_path).at_least(:once)
      FactoryGirl.build(:resource).valid?
    end
  end

  let(:folder)      { FactoryGirl.create(:folder) }
  let(:sub_folder)  { FactoryGirl.create(:folder, parent: folder)  }

  describe "#path" do
    it "overrides ancestry default method and returns an string" do
      folder.path.is_a? String
    end

    it "starts with a slash if is a root node" do
      folder.path.should =~ /^\//
    end

    it "returns the parents path" do
      sub_folder.path.should =~ Regexp.new(sub_folder.parent.path)
    end

    it "returns the urn os the asset " do
      folder.path.should =~ Regexp.new(folder.name)
    end
  end

  describe "#folder?" do
    it "returns true if asset is a folder false otherwise" do
      folder.folder?.should be_true
    end
  end

  describe "#update_childrens_path" do
    it "fires a signal to update childrens path"
  end

  describe ".to_collection" do
    it "maps all criteria values into a multi-dimensional array" do
      resources = FactoryGirl.create_list(:resource, 5)
      Resource.to_collection.should be_a(Array)
    end
  end

  describe ".assets" do
    it "returns an array with the modules classes" do
      Resource.assets.should be_an(Array)
      Resource.assets.first.should be_a(Class)
      Resource.assets.should_not include(Asset::Base)
    end
  end
end
