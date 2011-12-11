class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.text :content
      t.integer :comment_count
      t.string :title
      t.string :digest

      t.timestamps
    end
  end
end
