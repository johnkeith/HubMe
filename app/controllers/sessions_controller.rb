class SessionsController < ApplicationController
  def create
    auth = env['omniauth.auth']

    user = User.find_or_create_from_omniauth(auth)
    set_current_user(user)

    session[:access_token] = auth["credentials"]["token"]
    client = Octokit::Client.new(:access_token => session[:access_token], :auto_paginate => true)

    Repo.refresh_user_repos(user, client)

    flash[:notice] = "You're now signed in as #{user.username}!"

    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    # flash[:notice] = "You have been signed out."

    redirect_to '/', notice: "You have been signed out."
  end
end
