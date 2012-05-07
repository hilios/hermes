require 'spec_helper'

describe "Websites" do
  context "CRUD" do
    before(:each) do
      login_as(:admin)
    end

    it "lists all registered websites" do
      websites = FactoryGirl.create_list(:website, 5)
      visit websites_path
      # Check if all websites are listed
      websites.each do |website|
        page.should have_content(website.name)
      end
    end

    it "shows an website profile" do
      website = FactoryGirl.create(:website)
      # Go to websites page and find the website
      visit websites_path
      within("[data-id='#{website.id}']") do
        click_link 'Show'
      end
      # Check website info
      page.should have_content(website.name)
    end

    it "creates a new website" do
      visit websites_path
      click_link 'New Website'
      # Fill the form
      fill_in 'Name', :with => 'Hermes'
      click_button 'Create Website'

      page.should have_content('Hermes')
    end

    it "edits an website profile" do
      website = FactoryGirl.create(:website)
      # Go to websites page and find the website
      visit websites_path
      within("[data-id='#{website.id}']") do
        click_link 'Edit'
      end
      fill_in 'Name', :with => 'Hermes'
      click_button 'Update Website'

      page.should have_content('Hermes')
    end

    it "destroy an website" do
      website = FactoryGirl.create(:website)
      # Go to websites page and find the website
      visit websites_path
      within("[data-id='#{website.id}']") do
        click_link 'Destroy'
      end
      # Check website info
      page.should_not have_content(website.name)
    end
  end
end
