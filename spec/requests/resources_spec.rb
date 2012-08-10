require 'spec_helper'

describe "Resources" do
  before(:each) do
    @current_user = login_as(:admin)
    @current_website = @current_user.websites.first
  end
  
  it "lists" do
    website_resources = FactoryGirl.create_list(:resource, 5, website: @current_website)
    other_resources   = FactoryGirl.create_list(:resource, 5)

    visit manage_website_path(@current_website)

    visit resources_path
    current_path.should == resources_path
    # Show website name
    page.should have_content(@current_website.name)
    # Lists resources from current website
    website_resources.each do |resource|
      page.should have_content(resource.path)
    end
    # Not list resources from other websites
    other_resources.each do |resource|
      page.should_not have_content(resource.path)
    end
  end

end
