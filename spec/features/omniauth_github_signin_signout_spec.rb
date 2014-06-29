require 'rails_helper'

feature "user authorizes with github and creates account" do
  # before do
  #   request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  # end

  scenario "user is not signed in" do
    visit '/'

    expect(page).to_not have_content 'Sign out'
  end

  scenario "user creates an account and signs in" do
    user = FactoryGirl.create(:user)
  
    set_omniauth(user)

    visit '/'

    click_on 'Sign in with Github'
    # to see what's going on, use save_and_open_page

    expect(page).to_not have_content 'Sign in with Github'
    expect(page).to have_content 'Sign out'
  end

end
