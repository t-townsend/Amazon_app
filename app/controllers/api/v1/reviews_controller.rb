class Api::V1::ReviewsController < Api::BaseController

  def create
    @product = Product.find params[:product_id]
    review_params = params.require(:review).permit(:body, :rating)
    review = Review.new review_params
    @review.product = @product
    @review.user = User.find_by_api_token params[:api_token]

    if review.save
      render json: @product
    else
      render json: @product
    end
  end
end
