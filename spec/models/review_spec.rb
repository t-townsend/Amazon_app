require 'rails_helper'

RSpec.describe Review, type: :model do
  def review_attributes(new_review = {})
  {body: 'This is the worst book ever. 3 stars.',
    rating: 3
  }.merge(new_review)
  end

  it 'has a rating that is more than 0 and less than 6' do
    review = Review.new(review_attributes)
    expect(review.rating).to be_between(1, 5).inclusive
  end

  it 'requires a rating' do
    review = Review.new(review_attributes)
    expect(review).not_to eq(nil)
  end
end
