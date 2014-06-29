class SessionsController < ApplicationController
  def create
    auth = env['omniauth.auth']

    user = User.find_or_create_from_omniauth(auth)
    set_current_user(user)

    # need to find out how to stub this part for testings
    # ok_client = OctokitConnector.create(user)
    # Repo.refresh_user_repos(ok_client, user)

    flash[:notice] = "You're now signed in as #{user.username}!"
    redirect_to user_path(user.username)
  end

  def destroy
    session[:user_id] = nil
    # flash[:notice] = "You have been signed out."

    redirect_to '/', notice: "You have been signed out."
  end
end
