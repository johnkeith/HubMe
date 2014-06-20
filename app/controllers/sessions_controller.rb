class SessionsController < ApplicationController
  def create
    auth = env['omniauth.auth']
    # session[:access_token] = auth["credentials"]["token"]
    # client = Octokit::Client.new(:access_token => session[:access_token])
    # USING client I can get to all repos
    # client.repositories

    # octo_user = client.user
    # octo_user.login
    # eric says that my access token for octokit will be in this hash
    # do I need to save the user to a local database? what info would be worth saving?
    user = User.find_or_create_from_omniauth(auth)
    set_current_user(user)
    flash[:notice] = "You're now signed in as #{user.username}!"
    # binding.pry
    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    # flash[:notice] = "You have been signed out."

    redirect_to '/', notice: "You have been signed out."
  end
end
