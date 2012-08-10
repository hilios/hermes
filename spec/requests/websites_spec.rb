require 'spec_helper'

describe "Websites" do
  context "as admin" do
    before(:each) do
      login_as(:admin)
    end

    it "lists" do
      websites = FactoryGirl.create_list(:website, 5)
      visit websites_path
      # Check if all websites are listed
      websites.each do |website|
        page.should have_content(website.name)
      end
    end

    it "shows" do
      website = FactoryGirl.create(:website)
      # Go to websites page and find the website
      visit websites_path
      within("[data-id='#{website.id}']") do
        click_link 'Show'
      end
      # Check website info
      page.should have_content(website.name)
    end

    it "creates" do
      visit websites_path
      click_link 'New Website'
      # Fill the form
      fill_in 'Name', with: 'Foo Bar'
      fill_in_url     with: 'http://foobar.com'
      click_button 'Create Website'

      page.should have_content('Foo Bar')
    end

    it "updates" do
      website = FactoryGirl.create(:website)
      # Go to websites page and find the website
      visit websites_path
      within("[data-id='#{website.id}']") do
        click_link 'Edit'
      end
      fill_in 'Name', with: 'Foo Bar'
      click_button 'Update Website'

      page.should have_content('Foo Bar')
    end

    it "destroys" do
      website = FactoryGirl.create(:website)
      # Go to websites page and find the website
      visit websites_path
      within("[data-id='#{website.id}']") do
        click_link 'Destroy'
      end
      # Check website info
      page.should_not have_content(website.name)
    end

    it "manages" do
      websites = FactoryGirl.create_list(:website, 5)

      visit websites_path
      within("[data-id='#{websites.first.id}']") do
        click_link 'Manage'
      end
      current_path.should == resources_path
    end
  end
end
