class CreateRepoLanguages < ActiveRecord::Migration
  def change
    create_table :repo_languages do |t|
      t.integer :repo_id, null: false
      t.integer :language_id, null: false
      t.timestamps
    end
    add_index :repo_languages, [:repo_id, :language_id], unique: true
  end
end
