class SessionsController < ApplicationController
  def create
    auth = env['omniauth.auth']

    user = UserSignInService.sign_in!(auth)
    set_current_user(user)

    flash[:notice] = "You're now signed in as #{user.username}!"
    redirect_to user_path(user.username)
  end

  def destroy
    session[:user_id] = nil
    # flash[:notice] = "You have been signed out."

    redirect_to '/', notice: "You have been signed out."
  end
end
