class User < ActiveRecord::Base
  has_many :repos
  has_many :repo_languages, through: :repos
  has_many :languages, through: :repo_languages

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
      avatar_url: auth.info.image,
      access_token: auth.credentials.token
    )
  end

  # def calculate_language_totals
  #   self.repos.each do |repo|
  #     langs_in_repo = RepoLanguage.find_by(repo_id: repo.id)
  #     langs_in_repo.each |
  # end
end
