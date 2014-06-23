require 'rails_helper'

feature "user authorizes with github and creates account" do

  scenario "user is not signed in" do
    visit '/'

    expect(page).to_not have_content 'Sign out'
  end

  scenario " in" do
    # sign a user in using mock object
    user = User.create(
      provider: "github", 
      uid: "1234567",
      username: "johnkeith",
      avatar_url: "github.com",  
      email: "johnkeith@gmail.com"
    )
    set_omniauth(user)

    visit '/'

    click_on 'Sign in with Github'
    # to see what's going on, use save_and_open_page

    click_on 'Sign out'

    expect(page).to have_content 'Sign in with Github'
    expect(page).to_not have_content 'Sign out'
  end

end
