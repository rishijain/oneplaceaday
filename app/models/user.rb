class User < ActiveRecord::Base
  include PgSearch
  extend FriendlyId

  friendly_id :username, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  mount_uploader :profile_photo, ProfilePhotoUploader

  searchkick
  has_many :posts
  has_many :comments
  has_many :likes

  def my_all_posts
    Post.where(user_id: self.id, aasm_state: 'published').order('created_at DESC')
  end

  def facebook?
    provider == 'facebook'
  end

  def twitter?
    provider == 'twitter'
  end

  def has_liked_post?(post_id)
    like = Like.where(post_id: post_id, user_id: id).first
    like.present?
  end

  def draft_posts
    posts.draft
  end

  def published_posts
    posts.published
  end

  def moderation_posts
    posts.moderation
  end

  def self.from_omniauth(auth)
    user = self.where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end

    user.picture_url = auth.info.image

    if auth.provider.eql?('twitter')
      user.username = auth.info.nickname
      user.save(validate: false) # because twitter does not provide email
    else
      user.username = auth.info.name
      user.save
    end

    return user
  end

  #rebuild
   def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end
  # # #
end
