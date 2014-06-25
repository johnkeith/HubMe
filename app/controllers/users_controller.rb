class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
    @languages = @user.languages(:name).distinct
    @repos = @user.repos
  end
end
