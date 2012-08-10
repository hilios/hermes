require 'spec_helper'

describe Asset::Base do
  describe "collection" do
    it { should have_field(:_type).of_type(String) }
    it { should have_field(:name).of_type(String) }
  end
  
  describe "relations" do
    it { should be_embedded_in(:resource) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe ".model_name" do
    it "returns the name without" do
      Asset::Base.model_name.route_key.should == "base"
    end
  end
end