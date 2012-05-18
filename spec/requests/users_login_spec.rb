require 'spec_helper'

describe "Users login" do
  it "allows access to a registered user" do
    @current_user = FactoryGirl.create(:user)
    visit root_path
    login_as @current_user
    current_path.should_not == new_user_session_path
  end

  it "denies access to unregistered users" do
    login "bad", "user"
    current_path.should == new_user_session_path
    page.should have_content 'Invalid email or password'
  end
end
