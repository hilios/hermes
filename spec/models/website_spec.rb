require 'spec_helper'

describe Website do
  describe "collection" do
    it { should have_field(:name).of_type(String) }
  end

  describe "relations" do
    it { should have_many(:domains) }
  end

  describe "validations" do
    specify { Fabricate.build(:website).should be_valid }
    
    it { should validate_presence_of(:name) }
  end
end
