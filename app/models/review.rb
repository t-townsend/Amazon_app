class Review < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user
  
  belongs_to :product
  belongs_to :user
  def like_for(user)
    likes.find_by(user: user)
  end

  def like_by?(user)
    likes.exists?(user: user)
  end
  validates(:rating, { presence: true,
                     numericality: { less_than_or_equal_to: 5 }})
end
