class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  mount_uploader :profile_photo, ProfilePhotoUploader

  searchkick
  has_many :posts
  has_many :comments

  def my_posts
    Post.where(:user_id => self.id).order('created_at DESC')
  end

  def self.from_omniauth(auth)
    user = self.where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.profile_photo = auth.info.image
    end

    if auth.provider.eql?('twitter')
      user.save(validate: false) # because twitter does not provide email
    else
      user.save
    end

    return user
  end
end
