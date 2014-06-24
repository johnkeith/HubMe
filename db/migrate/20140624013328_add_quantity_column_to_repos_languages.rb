class AddQuantityColumnToReposLanguages < ActiveRecord::Migration
  def change
    add_column :repo_languages, :quantity, :integer
  end
end
