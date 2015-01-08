class Post < ActiveRecord::Base

  validates :title, :description, :place, :country, :visited_on, presence: true
end
