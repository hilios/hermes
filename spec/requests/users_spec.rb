require 'spec_helper'

describe "Users" do
  context "CRUD" do
    before(:each) do
      login_as(:admin)
    end

    it "lists all registered users" do
      users = FactoryGirl.create_list(:user, 5)
      visit users_path
      # Check if all users are listed
      users.each do |user|
        page.should have_content(user.name)
        page.should have_content(user.email)
      end
    end

    it "shows an user profile" do
      user = FactoryGirl.create(:user)
      # Go to users page and find the user
      visit users_path
      within("[data-id='#{user.id}']") do
        click_link 'Show'
      end
      # Check user info
      page.should have_content(user.name)
      page.should have_content(user.email)
      page.should have_content(user.role)
    end

    it "creates a new user" do
      visit users_path
      click_link 'New User'
      # Fill the form
      fill_in 'Name',     :with => 'Foo Bar'
      fill_in 'E-mail',   :with => 'foo.bar@host.com'
      fill_in 'Password', :with => 'abc1234'
      fill_in 'Password confirmation', :with => 'abc1234'
      choose 'webmaster'
      click_button 'Create User'

      page.should have_content('Foo Bar')
      page.should have_content('foo.bar@host.com')
    end

    it "edits an user profile" do
      user = FactoryGirl.create(:user)
      # Go to users page and find the user
      visit users_path
      within("[data-id='#{user.id}']") do
        click_link 'Edit'
      end
      fill_in 'Name', :with => 'John Doe'
      click_button 'Update User'

      page.should have_content('John Doe')
    end

    it "destroy an user" do
      user = FactoryGirl.create(:user)
      # Go to users page and find the user
      visit users_path
      within("[data-id='#{user.id}']") do
        click_link 'Destroy'
      end
      # Check user info
      page.should_not have_content(user.name)
      page.should_not have_content(user.email)
    end
  end
end
