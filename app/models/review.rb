class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  validates :rating, inclusion: 1..5

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_for(user)
    likes.find_by(user: user)
  end

  def votes_count
    votes.where(is_up: true).count - votes.where(is_up: false).count
  end

  def self.sort_by_votes(reviews)
    reviews.sort_by {|review| review.votes_count }.reverse
  end

end
