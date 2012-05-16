def login(email, password)
  visit new_user_session_path
  fill_in 'E-mail',   :with => email
  fill_in 'Password', :with => password
  click_button 'Sign in'
end

def login_as(user)
  user = FactoryGirl.create(user) if user.is_a? Symbol
  login(user.email, user.password)
  user
end