class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :subject_id, :avatar

  has_many :articles
  belongs_to :subject, :counter_cache => true

  mount_uploader :avatar, AvatarUploader

  def to_param
    self.name
  end
end
