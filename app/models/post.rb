class Post < ActiveRecord::Base

  mount_uploader :photo, PhotoUploader

  validates :title, :description, :place, :country, :visited_on, presence: true
end
