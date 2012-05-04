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
end