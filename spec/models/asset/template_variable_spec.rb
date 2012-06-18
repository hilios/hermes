require 'spec_helper'

describe Asset::TemplateVariable do
  describe "collection" do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:type).of_type(Symbol) }
    it { should have_field(:allow_blank).of_type(Boolean) }
  end

  describe "relations" do
    it { should be_embedded_in(:template) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    
    it { should allow_value('foo').for(:name) }
    it { should allow_value('foo123').for(:name) }
    it { should allow_value('fooBar').for(:name) }
    it { should allow_value('foo_bar').for(:name) }
    it { should_not allow_value('123foo').for(:name) }
    it { should_not allow_value('foo bar').for(:name) }
    it { should_not allow_value('foobar ').for(:name) }
    it { should_not allow_value(' foobar').for(:name) }
  end

  describe ".type_collection" do
    it "should return an array" do
      Asset::TemplateVariable.type_collection.should be_a(Array)
    end
  end
end
