class Api::V1::ProductsController < Api::BaseController
before_action :authenticate_user
  def index
    @products = Product.order(created_at: :desc)
  end

  def create
    review_params = params.require(:review).permit(:title, :body, :rating)
    review = Review.new review_params
    review.user = @user

    if review.save
      head :ok
    else
      render json: {error: review.errors.full_messages.join(', ')}
    end
  end


  def show
    @product = Product.find params[:id]
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

def authenticate_user
  @user = User.find_by_api_token params[:api_token]
  # head will send an empty HTTP response with a code that is inferred by the
  # symbol you pass as an argument to the `head` method
  head :unauthorized if @user.nil?
end

end
