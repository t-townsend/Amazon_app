class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :reviews

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader

  validates(:title, { presence: true,
                      uniqueness: { case_sensitive: false },
                      exclusion: { in: %w(Apple Microsoft Sony),
                                   message: "%{value} is reserved." } })
  validates(:description, { presence: true, length: { minimum: 10 } })
  validates(:price, { presence: true,
                      numericality: { greater_than: 0, less_than: 1000 } })
  # validates(:sale_price, { numericality: { less_than_or_equal_to: self.price } })

  validate :price_is_valid_decimal_precision
  validate :sale_price_is_not_greater_than_price

  after_initialize :set_defaults
  before_save :capitalize_title

  def self.search(string)
    where(['title ILIKE ? OR description ILIKE ?', "%#{string}%", "%#{string}%"]).order(['description ILIKE ?', "%#{string}%"], ['title ILIKE ?', "%#{string}%"])
  end

  def self.sort_filter(search_term, sort_by_column, current_page, per_page_count)
    if current_page > 0
      where(['title ILIKE ? OR description ILIKE ?', "%#{search_term}%", "%#{search_term}%"]).order(sort_by_column).limit(per_page_count).offset((current_page - 1) * per_page_count)
    end
  end

  def favourited_by?(user)
    favourites.exists?(user: user)
  end

  def favourite_for(user)
    favourites.find_by(user: user)
  end

  private

  def price_is_valid_decimal_precision
    # Make sure that the rounded value is the same as the non-rounded
    if price.to_f != price.to_f.round(2)
      errors.add(:price, "The price of the product is invalid. There should only be two digits at most after the decimal point.")
    end
  end

  def sale_price_is_not_greater_than_price
    if sale_price > price
      errors.add(:sale_price, "The sale price must not be greater than the price.")
    end
  end

  def set_defaults
    self.price ||= 1
    self.sale_price ||= self.price
  end

  def capitalize_title
    # self.title = title.capitalize! if title.present?
    self.title = title.titleize if title.present?
  end

end
