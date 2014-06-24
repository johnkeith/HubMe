class RepoLanguage < ActiveRecord::Base
  belongs_to :repo
  belongs_to :language
end
