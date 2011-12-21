class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, :counter_cache => true
  mount_uploader :image, ArticleUploader

  def user_name
    user.name
  end
end
