class Repo < ActiveRecord::Base
  belongs_to :user
  has_many :repo_languages
  has_many :languages, through: :repo_languages
end
