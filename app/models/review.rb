class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates(:rating, { presence: true,
                     numericality: { less_than_or_equal_to: 5 }})
end
