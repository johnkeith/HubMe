class UserSignInService
  def self.sign_in!(auth)
    user = User.find_or_create_from_omniauth(auth)

    client = Octokit::Client.new(access_token: auth.credentials.token, auto_paginate: true)

    Repo.refresh_user_repos(user, client)
  end
end
