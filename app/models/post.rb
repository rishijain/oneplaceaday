class Post < ActiveRecord::Base
  belongs_to :user

  mount_uploader :photo, PhotoUploader

  validates :title, :description, :place, :country, :visited_on, presence: true

end
