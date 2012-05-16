require 'spec_helper'

describe "Websites select" do
  before(:each) do
    @websites = FactoryGirl.create_list(:website, 2)
    @current_user = login_as(:copywriter)
  end

  it "allows user to choose a site to manage their resources" do
    @current_user.websites = @websites

    visit select_websites_path
    within("[data-id='#{@websites.first.id}']") do
      click_link 'Manage'
    end
    current_path.should == website_resources_path(@websites.first)
  end

  it "redirects automatically to resourcer if user has only one site assigned" do
    @current_user.websites = [@websites.first]
    visit select_websites_path
    current_path.should == website_resources_path(@websites.first)
  end
end