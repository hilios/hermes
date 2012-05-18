require 'spec_helper'

describe Resource::StaticAsset do
  describe "collection" do
    it { should have_field(:content_type).of_type(String) }
    it { should have_field(:body).of_type(Object) }
  end
  
  describe "relations" do
    it { should be_embedded_in(:resource) }
  end
end
