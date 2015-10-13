def sign_in(user)
  first("a[href='/users/sign_out']").try(:click)
  visit new_user_session_path
  fill_in 'user[email]', with: user.email
  fill_in 'user[password]', with: FactoryGirl.attributes_for(:user)[:password]
  click_button 'Zaloguj się'
end
