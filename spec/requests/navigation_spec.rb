require 'spec_helper'

describe "Navigation" do
  context "as admin" do
    before { login_as(:admin) }

    specify do 
      within "header nav" do
        click_link "Resources"
        click_link "Users"
        click_link "Websites"
      end
    end
  end
end