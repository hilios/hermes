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
    def website(url)
      @website ||= FactoryGirl.create(:website, :domains => [FactoryGirl.create(:domain, :url => url)])
    end

    it "returns the website that matchs the uri"
  end
end
