require 'spec_helper'

describe Role do
  describe "#initialize" do
    it "receives a name" do
      role = Role.new("bar")
      role.name.should == "bar"
    end
  end
  
  let(:role) { Role.new("foo") }
  
  describe "#name" do
    subject { role.name }
    it { should == "foo" }
  end
  
  describe "#to_s" do
    subject { role.to_s }
    it { should be_a(String) }
    it { should == "foo" }
  end
  
  describe "#to_sym" do
    subject { role.to_sym }
    it { should be_a(Symbol) }
    it { should == :foo }
  end
  
  describe ".all" do
    it "returns an array" do
      Role.all.should be_a(Array)
    end
  end
  
  describe ".find" do
    it "returns an instace of the requested Role, nil if could not find" do
      Role.find(Role.all.first).should be_a(Role)
    end
    
    it "raises an error if request role does not exists" do
      lambda { Role.find(:foo_bar) }.should raise_error
    end
  end
end
