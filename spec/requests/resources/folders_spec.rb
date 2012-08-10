# require 'spec_helper'

# describe "Folder resources" do
#   before(:each) do
#     @current_user = login_as(:admin)
#     @current_website = @current_user.websites.first
#   end
  
#   it "lists" do
#     folders = FactoryGirl.create_list(:folder, 5, :website => @current_website)
#     visit resources_path
#     # Check if all folders were listed
#     folders.each do |folder|
#       page.should have_content(folder.uri)
#     end
#   end

#   it "shows" do
#     folder = FactoryGirl.create(:folder, :website => @current_website)
#     # Go to folders page and find the folder
#     visit resources_path
#     within("[data-id='#{folder.id}']") do
#       click_link 'Show'
#     end
#     # Check folder info
#     page.should have_content(folder.urn)
#   end

#   it "creates" do
#     # Go to resources page and create new folder
#     visit resources_path
#     click_link 'Folder'
#     # Fill the form
#     fill_in 'Urn', :with => 'foo-bar'
#     click_button 'Create Resource'
#     # Check if folder was created
#     page.should have_content('foo-bar')
#   end

#   it "updates" do
#     folder = FactoryGirl.create(:folder, :website => @current_website)
#     # Go to resources page and edit folder
#     visit resources_path
#     within("[data-id='#{folder.id}']") do
#       click_link 'Edit'
#     end
#     # Fill the form
#     fill_in 'Urn', :with => 'woo-hoo'
#     click_button 'Update Resource'
#     # Check if folder was updated
#     page.should have_content('woo-hoo')
#   end

#   it "destroys" do
#     folder = FactoryGirl.create(:folder, :website => @current_website)
#     # Go to resources page and destroy folder
#     visit resources_path
#     within("[data-id='#{folder.id}']") do
#       click_link 'Destroy'
#     end
#     # Check if folder info exists
#     page.should_not have_content(folder.uri)
#   end
# end
