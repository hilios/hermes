require 'spec_helper'

describe Asset::Template do
  describe "collection" do
    it { should have_field(:content).of_type(String) }
  end

  describe "relations" do
    it { should embed_many(:variables).of_type(Asset::TemplateVariable) }
    it { should belong_to(:template) }
  end
end
