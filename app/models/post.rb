class Post < ActiveRecord::Base

  include AASM
  include PgSearch
  belongs_to :user
  has_many :comments
  has_many :likes

  #search:
  pg_search_scope :search,
    :against => [:title, :description, :place, :country],
    :associated_against => { :user => :username },
    :using => {
      :trigram => {
        :threshold => 0.05
      },
     :tsearch => {
      :dictionary  => 'english'
      }
    }
  #end of search

  mount_uploader :photo, PhotoUploader

  validates :title, :description, :place, :country, :visited_on, :photo, presence: true, if: Proc.new {|d| d.published?}

  geocoded_by :full_street_address
  after_validation :geocode, if: :full_street_address_changed?

  scope :all_except, -> (post_id) { where.not(id: post_id) }
  self.per_page = 3

  aasm do
    state :draft, initial: true
    state :moderation
    state :published

    event :draft do
      transitions from: [:published, :moderation], to: :draft
    end

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

  #rebuild
  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end
  # # #

end
