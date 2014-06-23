class User < ActiveRecord::Base
  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid

    find_by(provider: provider, uid: uid) || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      username: auth.info.nickname,
      avatar_url: auth.info.image
    )
  end

  def self.gather_repo_data(auth, user)
    session[:access_token] = auth["credentials"]["token"]
    client = Octokit::Client.new(:access_token => session[:access_token])
    client.repositories
    # ask EEs - how should I structure it so that it can save
    # to the user model and the repos model and the langs model
  end
end
