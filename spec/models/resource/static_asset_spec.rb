require 'spec_helper'

describe Resource::StaticAsset do
  describe "collection" do
    it { should have_fields(:content_type, :body).of_type(String) }
  end
  
  describe "relations" do
    it { should be_embedded_in(:resource) }
  end
end
