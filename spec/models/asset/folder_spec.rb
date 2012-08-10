require 'spec_helper'

describe Asset::Folder do
  describe "collection" do
    it { should have_field(:name).of_type(String) }
  end
end
