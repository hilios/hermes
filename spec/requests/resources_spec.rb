require 'spec_helper'

describe "Resources" do
  before(:each) do
    @current_user = login_as(:admin)
    @current_website = @current_user.websites.first
  end
  
  it "shows all website resources" do
    visit website_resources_path(@current_website)
    
    page.should have_content(@current_website.name)
  end
end
