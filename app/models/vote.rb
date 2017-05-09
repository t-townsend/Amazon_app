class Vote < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates :is_up, inclusion: { in: [true, false] }
  validates :user_id, uniqueness: { scope: :product_id, message: 'You already voted'}
end
