class ReviewsController < ApplicationController
before_action :authenticate_user!, only: [:create, :destroy]

  def create
  @product = Product.find params[:product_id]
  review_params = params.require(:review).permit(:body, :rating)
  @review = Review.new review_params
  @review.product = @product
  @review.user = current_user

  respond_to do |format|
    if @review.save
      ReviewsMailer.notify_prod_review_owner(@review).deliver_now
     format.html { redirect_to product_path(@product), notice: "Answer created successfully!" }
     format.js { render :create_success }
   else
     format.html { render "products/show" }
     format.js   { render :create_failure }
      end
    end
  end

    def destroy
    @product = Product.find params[:product_id]
    @review = Review.find params[:id]
    @review.destroy
    respond_to do |format|
      format.html { redirect_to question_path(@answer.question), notice: "Answer deleted" }
      format.js   { render } # this renders /app/views/answers/destroy.js.erb
    end
  end
end
