require 'spec_helper'

describe "Resource Static" do
  before(:each) do
    @current_user = login_as(:admin)
    @current_website = @current_user.websites.first
  end
  
  it "lists static assets" do
    images = FactoryGirl.create_list(:image, 2, :website => @current_website)
    visit website_resources_path(@current_website)
    # Check if all images were listed
    images.each do |image|
      page.should have_content(image.uri)
    end
  end

  it "shows static asset information" do
    image = FactoryGirl.create(:image, :website => @current_website)
    # Go to images page and find the image
    visit website_resources_path(@current_website)
    within("[data-id='#{image.id}']") do
      click_link 'Show'
    end
    # Check image info
    page.should have_selector("img[src$='#{preview_website_resource_path(@current_website, image)}']")
  end

  it "creates a new image" do
    # Go to resources page and create new image
    visit website_resources_path(@current_website)
    click_link 'Static'
    # Fill the form
    attach_file '* Content', upload(:jpg).path
    click_button 'Create Resource'
    # Check if image was created
    page.should have_selector("img[src$='#{preview_website_resource_path(@current_website, Resource.last)}']")
  end

  it "updates image information" do
    folder = FactoryGirl.create(:folder, :website => @current_website)
    image = FactoryGirl.create(:image, :website => @current_website)
    # Go to resources page and edit image
    visit website_resources_path(@current_website)
    within("[data-id='#{image.id}']") do
      click_link 'Edit'
    end
    # Fill the form
    select folder.urn
    click_button 'Update Resource'
    # Check if image was updated
    page.should have_selector("img[src$='#{preview_website_resource_path(@current_website, image)}']")
  end

  it "destroys image" do
    image = FactoryGirl.create(:image, :website => @current_website)
    # Go to resources page and destroy image
    visit website_resources_path(@current_website)
    within("[data-id='#{image.id}']") do
      click_link 'Destroy'
    end
    # Check if image info exists
    page.should have_no_selector("img[src$='#{preview_website_resource_path(@current_website, image)}']")
  end
end
