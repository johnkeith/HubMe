class Repo < ActiveRecord::Base
  belongs_to :user
  has_many :repo_languages
  has_many :languages, through: :repo_languages

  def self.refresh_user_repos(user, client)
    # client = Octokit::Client.new(:access_token => session[:access_token], :auto_paginate => true)

    client.repositories.each do |repo|
      if Repo.where(user_id: user.id, name: repo[:name]).empty?
        added_repo = Repo.create(user_id: user.id, name: repo[:name], html_url: repo[:html_url], profile_visibility: true )
      end

      repo_langs = client.languages(repo[:full_name]).to_attrs

      repo_langs.each do |lang_name, code_amount|
        if added_repo.nil?
          next
        elsif Language.where(name: lang_name).empty?
          new_lang = Language.create(name: lang_name)
          RepoLanguage.create(repo_id: added_repo.id, language_id: new_lang.id, quantity: code_amount)
        else
          old_lang = Language.where(name: lang_name)
          RepoLanguage.create(repo_id: added_repo.id, language_id: old_lang[0].id, quantity: code_amount)
        end
      end
    end
  # return new repos added
  end

  def omniauth_client
    Octokit::Client.new(access_token: auth.credentials.token, auto_paginate: true)
  end
end
