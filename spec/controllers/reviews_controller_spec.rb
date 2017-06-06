require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:product) { FactoryGirl.create(:product) }
  let(:user) { FactoryGirl.create(:user) }
  # let(:review) { FactoryGirl.create(:review, { user: user }) }

  describe '#create' do
    def valid_attributes(new_attributes = {})
      attributes = {
        body: "This product is amazing",
        rating: 4
      }
      attributes.merge(new_attributes)
    end
    def valid_request
      post :create, params: {
        review: FactoryGirl.attributes_for(:review),
        product_id: product.id
      }
    end

    context 'with user signed in' do
      before { request.session[:user_id] = user.id }
      it 'creates a review in the database' do
        count_before = Review.count
        review = Review.create(valid_attributes)
        count_after = Review.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'associates the review with the signed-in user' do
        review = Review.create(valid_attributes({user_id: user.id}))
        expect(Review.last.user).to eq(user)
      end
      it 'redirects to the product_path' do
        valid_request
        expect(response).to redirect_to(product_path(product))
      end
    end

    context 'with user not signed in' do
      it 'redirects to the sign in page' do
        post :create, params: {
          review: FactoryGirl.attributes_for(:review),
          product_id: product.id
        }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
