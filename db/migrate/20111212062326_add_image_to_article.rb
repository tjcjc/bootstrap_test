class AddImageToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :image, :string
    add_column :articles, :subject_id, :integer
  end
end
