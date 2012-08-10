# require 'spec_helper'

# describe "Static resources" do
#   before(:each) do
#     @current_user = login_as(:admin)
#     @current_website = @current_user.websites.first
#   end
  
#   it "lists" do
#     images = FactoryGirl.create_list(:image, 2, :website => @current_website)
#     visit resources_path
#     # Check if all images were listed
#     images.each do |image|
#       page.should have_content(image.uri)
#     end
#   end

#   it "shows" do
#     image = FactoryGirl.create(:image, :website => @current_website)
#     # Go to images page and find the image
#     visit resources_path
#     within("[data-id='#{image.id}']") do
#       click_link 'Show'
#     end
#     # Check image info
#     page.should have_selector("img[src$='#{preview_website_resource_path(@current_website, image)}']")
#   end

#   it "creates" do
#     # Go to resources page and create new image
#     visit resources_path
#     click_link 'Static'
#     # Fill the form
#     attach_file '* Content', upload(:jpg).path
#     click_button 'Create Resource'
#     # Check if image was created
#     page.should have_selector("img[src$='#{preview_website_resource_path(@current_website, Resource.last)}']")
#   end

#   it "updates" do
#     folder = FactoryGirl.create(:folder, :website => @current_website)
#     image = FactoryGirl.create(:image, :website => @current_website)
#     # Go to resources page and edit image
#     visit resources_path
#     within("[data-id='#{image.id}']") do
#       click_link 'Edit'
#     end
#     # Fill the form
#     select folder.urn
#     click_button 'Update Resource'
#     # Check if image was updated
#     page.should have_selector("img[src$='#{preview_website_resource_path(@current_website, image)}']")
#   end

#   it "destroys" do
#     image = FactoryGirl.create(:image, :website => @current_website)
#     # Go to resources page and destroy image
#     visit resources_path
#     within("[data-id='#{image.id}']") do
#       click_link 'Destroy'
#     end
#     # Check if image info exists
#     page.should have_no_selector("img[src$='#{preview_website_resource_path(@current_website, image)}']")
#   end
# end
