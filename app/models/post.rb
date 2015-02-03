class Post < ActiveRecord::Base
  belongs_to :user

  mount_uploader :photo, PhotoUploader

  validates :title, :description, :place, :country, :visited_on, :photo, presence: true

  self.per_page = 3
end
