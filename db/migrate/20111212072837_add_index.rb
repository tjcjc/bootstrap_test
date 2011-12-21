class AddIndex < ActiveRecord::Migration
  def change
    add_index :users, :subject_id
    add_index :articles, :user_id
    add_index :articles, :subject_id
    add_index :subjects, :parent_id
  end
end
