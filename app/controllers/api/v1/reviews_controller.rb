class Api::V1::ReviewsController < Api::BaseController
  def create
    @product = Product.find(params[:product_id])
    @review = Review.new review_params
    @review.product = @product
    @review.user = @user

    if @review.save
      render json: "Review created!"
    else
      render json: @review.errors.full_messages
    end
  end

  private

    def review_params
      params.require(:review).permit([ :body, :rating ])
    end
end
