class SessionsController < ApplicationController
  def create
    auth = env['omniauth.auth']

    user = User.find_or_create_from_omniauth(auth)
    set_current_user(user)

    session[:access_token] = auth["credentials"]["token"]
    # pagination limiting.... what can be done?
    client = Octokit::Client.new(:access_token => session[:access_token], :per_page => "10000")
    
    client.repositories.each do |repo|
      if Repo.where(user_id: user.id, name: repo[:name]).empty?
        added_repo = Repo.create(user_id: user.id, name: repo[:name], html_url: repo[:html_url], profile_visibility: true )
      end

      repo_langs = client.languages(repo[:full_name]).to_attrs

      repo_langs.each do |lang_name, code_amount|
        if Language.where(name: lang_name).empty?
          new_lang = Language.create(name: lang_name)
          RepoLanguage.create(repo_id: added_repo.id, language_id: new_lang.id)
        else
          old_lang = Language.where(name: lang_name)
          RepoLanguage.create(repo_id: added_repo.id, language_id: old_lang[0].id)
        end
      end
      # puts repo[:name]
    end


    flash[:notice] = "You're now signed in as #{user.username}!"

    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    # flash[:notice] = "You have been signed out."

    redirect_to '/', notice: "You have been signed out."
  end
end
