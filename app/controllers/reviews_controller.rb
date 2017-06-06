class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @product = Product.find(params[:product_id])
    review_params = params.require(:review).permit(:body, :rating)
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user

    if @review.save
      ReviewsMailer.notify_product_owner(@review).deliver_now
      redirect_to product_path(@product), notice: 'Review created!'
    else
      render '/products/show'
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to product_path(review.product), notice: 'Review deleted'
  end

  def update
    review = Review.find(params[:id])
    if review.is_hidden?
      review.update({ is_hidden: false })
      redirect_to product_path(review.product), notice: 'Review shown'
    else
      review.update({ is_hidden: true })
      redirect_to product_path(review.product), notice: 'Review hidden'
    end
  end
end
