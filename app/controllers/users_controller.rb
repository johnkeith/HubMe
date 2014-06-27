class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
    @languages = @user.languages(:name).distinct
    @repos = @user.repos
    @langs_in_bytes = @user.lang_totals_in_bytes
    @langs_as_percents = @user.lang_totals_as_percents(@user.lang_totals_in_bytes)
  end
end
