require 'spec_helper'

describe "Resource Folder" do
  before(:each) do
    @current_user = login_as(:admin)
    @current_website = @current_user.websites.first
  end
  
  it "lists folders" do
    folders = FactoryGirl.create_list(:folder, 5, :website => @current_website)
    visit website_resources_path(@current_website)
    # Check if all folders were listed
    folders.each do |folder|
      page.should have_content(folder.uri)
    end
  end

  it "shows folder information" do
    folder = FactoryGirl.create(:folder, :website => @current_website)
    # Go to folders page and find the folder
    visit website_resources_path(@current_website)
    within("[data-id='#{folder.id}']") do
      click_link 'Show'
    end
    # Check folder info
    page.should have_content(folder.urn)
  end

  it "creates a new folder" do
    # Go to resources page and create new folder
    visit website_resources_path(@current_website)
    click_link 'Folder'
    # Fill the form
    fill_in 'Urn', :with => 'foo-bar'
    click_button 'Create Resource'
    # Check if folder was created
    page.should have_content('foo-bar')
  end

  it "updates folder information" do
    folder = FactoryGirl.create(:folder, :website => @current_website)
    # Go to resources page and edit folder
    visit website_resources_path(@current_website)
    within("[data-id='#{folder.id}']") do
      click_link 'Edit'
    end
    # Fill the form
    fill_in 'Urn', :with => 'woo-hoo'
    click_button 'Update Resource'
    # Check if folder was updated
    page.should have_content('woo-hoo')
  end

  it "destroys folder" do
    folder = FactoryGirl.create(:folder, :website => @current_website)
    # Go to resources page and destroy folder
    visit website_resources_path(@current_website)
    within("[data-id='#{folder.id}']") do
      click_link 'Destroy'
    end
    # Check if folder info exists
    page.should_not have_content(folder.uri)
  end
end
