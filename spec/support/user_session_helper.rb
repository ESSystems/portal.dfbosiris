module UserSessionHelper
  
  def login_user(*args)
    @logged_in_user = Factory.create(:user, *args)
    visit new_user_session_path
    fill_in("Username", :with => @logged_in_user.username)
    fill_in("Password", :with => @logged_in_user.password)
    click_button("Sign in")
    page.should have_content("Signed in successfully.")
  end
end