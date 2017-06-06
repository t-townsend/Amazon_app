class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    product = review.product

    if cannot? :like, review
      redirect_to(
        product_path(product),
        alert: 'Liking your own review is not allowed'
      )
      return
    end

    like = Like.new(user: current_user, review: review)

    if like.save
      redirect_to product_path(product), notice: 'Review liked!'
    else
      redirect_to(
        product_path(product),
        alert: like.errors.full_messages.join(', ')
      )
    end
  end

  def destroy
    like = Like.find(params[:id])
    product = like.review.product

    if cannot? :like, like.review
      redirect_to(
        product_path(product),
        alert: 'Unliking your own review is not allowed'
      )
      return
    end

    if like.destroy
      redirect_to product_path(product), notice: 'Review unliked... :('
    else
      redirect_to product_path(product),
        alert: like.errors.full_messages.join(', ')
    end
  end
end
