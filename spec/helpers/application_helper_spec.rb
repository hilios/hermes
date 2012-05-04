require 'spec_helper'

describe ApplicationHelper do
  describe "#flash_messages" do
    it "should render the correct partial" do
      flash[:notice] = "notice message"
      flash[:warning] = "warning message"
      messages = helper.flash_messages
      messages.should have_css('div.alert')
      messages.should have_css('div.alert > a.close')
      messages.should have_content(flash[:notice])
      messages.should have_content(flash[:warning])
    end

    it "should only show the given type" do
      flash[:notice] = "notice message" 
      flash[:warning] = "warning message"
      messages = helper.flash_messages(:notice)
      messages.should have_content(flash[:notice])
      messages.should_not have_content(flash[:warning])
    end

    it "should render the correct class for :notice" do
      flash[:notice] = "test"
      helper.flash_messages.should have_css('div.alert-success')
    end

    it "should render the correct class for :info" do
      flash[:info] = "test"
      helper.flash_messages.should have_css('div.alert-info')
    end

    it "should render the correct class for :error" do
      flash[:error] = "test"
      helper.flash_messages.should have_css('div.alert-error')
    end
  end

  describe "#link_to_destroy" do
    it "should create a link with data-method=delete and confirmation" do
      link = helper.link_to_destroy('Delete', '/delete')
      link.should have_css('a[data-method="delete"]')
      link.should have_css('a[data-confirm]')
      link.should have_content('Delete')
    end

    it "should work with blocks too" do
      link = helper.link_to_destroy('/delete') { 'Delete' }
      link.should have_css('a[data-method="delete"]')
      link.should have_css('a[data-confirm]')
      link.should have_content('Delete')
    end

    it "should be able to override the settings" do
      link = helper.link_to_destroy('Delete', '/delete', method: :put)
      link.should have_css('a[data-method="put"]')
      link.should have_css('a[data-confirm]')
    end
  end
  
  describe "#module_is?" do
    before(:each) do
      controller.params[:controller] = "test/controller"
    end

    it "should return true/false if the module name(s) matchs" do
      helper.module_is?('test').should be_true
      helper.module_is?('fake').should be_false
      helper.module_is?('fake', 'test').should be_true
      helper.module_is?('fake', 'mock').should be_false
      # Same test with symbols
      helper.module_is?(:test).should be_true
      helper.module_is?(:fake).should be_false
      helper.module_is?(:fake, :test).should be_true
      helper.module_is?(:fake, :mock).should be_false
    end

    it "should execute block instead of returning true or fale" do
      helper.module_is?('test') { |b| b.should be_true }
      helper.module_is?('fake') { |b| b.should be_false }
      helper.module_is?(:fake, :test) { |b| b.should be_true }
      helper.module_is?(:fake, :mock) { |b| b.should be_false }
    end
  end

  describe "#controller_is?" do
    before(:each) do
      controller.params[:controller] = "test"
    end
    
    it "should return true or false for controller name(s)" do
      helper.controller_is?('test').should be_true
      helper.controller_is?('fake').should be_false
      helper.controller_is?('fake', 'test').should be_true
      helper.controller_is?('fake', 'mock').should be_false
      # Same test with symbols
      helper.controller_is?(:test).should be_true
      helper.controller_is?(:fake).should be_false
      helper.controller_is?(:fake, :test).should be_true
      helper.controller_is?(:fake, :mock).should be_false
    end
    
    it "should execute block instead of returning true or fale" do
      helper.controller_is?('test') { |b| b.should be_true }
      helper.controller_is?('fake') { |b| b.should be_false }
      helper.controller_is?(:fake, :test) { |b| b.should be_true }
      helper.controller_is?(:fake, :mock) { |b| b.should be_false }
    end
  end
  
  describe "#action_is?" do
    before(:each) do
      controller.params[:action] = "test"
    end
    
    it "should return true or false for action name(s)" do
      helper.action_is?('test').should be_true
      helper.action_is?('fake').should be_false
      helper.action_is?('fake', 'test').should be_true
      helper.action_is?('fake', 'mock').should be_false
      # Same test with symbols
      helper.action_is?(:test).should be_true
      helper.action_is?(:fake).should be_false
      helper.action_is?(:fake, :test).should be_true
      helper.action_is?(:fake, :mock).should be_false
    end
    
    it "should execute block instead of returning true or fale" do
      helper.action_is?('test') { |b| b.should be_true }
      helper.action_is?('fake') { |b| b.should be_false }
      helper.action_is?(:fake, :test) { |b| b.should be_true }
      helper.action_is?(:fake, :mock) { |b| b.should be_false }
    end
  end
end