class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  mount_uploader :photo, PhotoUploader

  validates :title, :description, :place, :country, :visited_on, :photo, presence: true

  self.per_page = 3
end
