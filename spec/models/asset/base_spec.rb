require 'spec_helper'

describe Asset::Base do
  describe "collection" do
    it { should have_field(:urn).of_type(String) }
  end
  
  describe "relations" do
    it { should be_embedded_in(:resource) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:urn) }
  end
end
