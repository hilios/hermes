require 'spec_helper'

describe Resource do
  describe "collection" do
    it { should have_field(:is_public).of_type(Boolean) }
    it { should have_field(:uri).of_type(String) }
    it { should have_field(:asset_type).of_type(String) }
    
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
  end
end
