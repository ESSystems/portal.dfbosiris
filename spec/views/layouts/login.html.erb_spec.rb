require "spec_helper"

describe "devise/sessions/new.html.erb" do

  let(:form_selector) do
    "//form[@id='new_user' and @method='post' and @action='#{user_session_path}']"
  end

  before do
  	visit new_user_session_path
  end

  it "doesn't show remember me checkbox" do
  	page.should_not have_selector(form_selector + "//input[@type='checkbox']")
  end

  it "doesn't show label for remember me" do
  	page.should_not have_selector(form_selector + "//label[@for='user_remember_me']")
  end

  it "doesn't show 'Remember me' label" do
  	page.should_not have_content("Remember me")
  end

end