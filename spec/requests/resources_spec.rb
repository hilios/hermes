require 'spec_helper'

describe "Resources" do
  before(:each) do
    @current_user = login_as(:admin)
    @current_website = @current_user.websites.first
  end
  
  it "shows resources for selected website" do
    website_resources = FactoryGirl.create_list(:resource, 5, :website => @current_website)
    other_resources   = FactoryGirl.create_list(:resource, 5)

    visit website_resources_path(@current_website)
    page.should have_content(@current_website.name)

    website_resources.each do |resource|
      page.should have_content(resource.uri)
    end
    other_resources.each do |resource|
      page.should_not have_content(resource.uri)
    end
  end

end
