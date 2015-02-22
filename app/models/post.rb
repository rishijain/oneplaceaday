class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  mount_uploader :photo, PhotoUploader

  validates :title, :description, :place, :country, :visited_on, :photo, presence: true

  geocoded_by :full_street_address
  after_validation :geocode, if: :full_street_address_changed?

  self.per_page = 3

  private

  def full_street_address
    "#{place}, #{country}"
  end

  def full_street_address_changed?
    result = place_changed? || country_changed?
  end
end
