require 'rails_helper'

RSpec.describe Review, type: :model do
  def valid_attributes(new_attributes)
    attributes = {
      body: "This product is amazing",
      rating: 4
    }
    attributes.merge(new_attributes)
  end
  describe 'validations' do
    it 'requires a rating to be present' do
      review = Review.new(valid_attributes({rating: nil}))
      expect(review).to be_invalid
    end
    it 'requires the rating to be from 1 to 5 inclusive' do
      review = Review.new(valid_attributes({rating: 0}))
      expect(review).to be_invalid
      review = Review.new(valid_attributes({rating: 1}))
      expect(review).to be_valid
      review = Review.new(valid_attributes({rating: 3}))
      expect(review).to be_valid
      review = Review.new(valid_attributes({rating: 5}))
      expect(review).to be_valid
      review = Review.new(valid_attributes({rating: 6}))
      expect(review).to be_invalid
    end
  end
end
