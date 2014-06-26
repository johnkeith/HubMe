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

  def user_languages_as_hash
    langs_hash = {}

    self.languages.each do |lang|
      langs_hash[lang[:name]] = 0
    end

    langs_hash
  end

  def user_languages_as_percents(langs_hash)
    total = langs_hash.values.sum

    langs_hash.each do |lang, amount|
      langs_hash[lang] = (amount / total.to_f) * 100
    end

    langs_hash
  end

  def calculate_language_totals
    langs_hash = user_languages_as_hash

    self.repo_languages.each do |repo_language|
      lang = Language.find_by(id: repo_language.language_id).name
      langs_hash[lang] += repo_language.quantity
    end
    
    user_languages_as_percents(langs_hash)
  end

end
