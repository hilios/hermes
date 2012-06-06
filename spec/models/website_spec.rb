require 'spec_helper'

describe Website do
  describe "collection" do
    it { should have_field(:name).of_type(String) }
  end

  describe "relations" do
    it { should have_many(:domains).with_dependent(:destroy) }
    it { should have_many(:resources).with_dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe ".for" do
    def website(url = nil)
      @website = FactoryGirl.create(:website, :domains => [FactoryGirl.create(:domain, :url => url)]) unless url.nil?
      @website
    end

    it "returns the website that matchs the uri" do
      website("http://*.hello.com.br")

      Website.for("http://www.hello.com.br").should == website
      Website.for("http://abc.hello.com.br").should == website
      Website.for("http://hello.com.br").should == website
    end
  end
end
