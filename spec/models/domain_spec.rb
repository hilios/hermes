require 'spec_helper'

describe Domain do
  describe "collection" do
    it { should have_field(:url).of_type(String) }
    it { should have_field(:default_params).of_type(Hash) }
  end

  describe "relations" do
    it { should belong_to(:website) }
  end

  describe "validations" do
    specify { Fabricate.build(:domain).should be_valid }
    
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url).case_insensitive }

    it { should allow_value("https://www.host.com").for(:url) }
    it { should allow_value("http://www.host.com.br").for(:url) }
    it { should allow_value("http://www.host.com").for(:url) }
    it { should allow_value("http://www.host.co").for(:url) }
    it { should allow_value("http://*.host.com").for(:url) }
    it { should allow_value("http://host.com").for(:url) }
    it { should allow_value("http://host.com.es").for(:url) }
    
    it { should allow_value("http://localhost").for(:url) }
    it { should allow_value("http://localhost:3000").for(:url) }

    it { should_not allow_value("ssh://host.com").for(:url) }
    it { should_not allow_value("http://").for(:url) }
    it { should_not allow_value("host.com").for(:url) }
    it { should_not allow_value("host").for(:url) }
  end
end
