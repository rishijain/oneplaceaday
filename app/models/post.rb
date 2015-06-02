class Post < ActiveRecord::Base

  include AASM

  belongs_to :user
  has_many :comments
  has_many :likes

  mount_uploader :photo, PhotoUploader

  validates :title, :description, :place, :country, :visited_on, :photo, presence: true

  geocoded_by :full_street_address
  after_validation :geocode, if: :full_street_address_changed?

  scope :all_except, -> (post_id) { where.not(id: post_id) }
  self.per_page = 3

  aasm do
    state :draft, initial: true
    state :moderation
    state :published

    event :publish do
      transitions from: [:draft, :moderation], to: :published
    end

    event :moderate do
      transitions from: [:draft, :published], to: :moderation
    end
  end

  def description
    super && super.html_safe
  end

  private

  def full_street_address
    "#{place}, #{country}"
  end

  def full_street_address_changed?
    result = place_changed? || country_changed?
  end
end
