require 'spec_helper'

describe Asset::Folder do
  describe "collection" do
    it { should have_field(:urn).of_type(String) }
  end
end
