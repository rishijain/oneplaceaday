class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_photo, ProfilePictureUploader

  has_many :posts

  def my_posts
    Post.where(:user_id => self.id).order('created_at DESC')
  end
end
