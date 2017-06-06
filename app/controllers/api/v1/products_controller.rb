class Api::V1::ProductsController < Api::BaseController
  def index
    @products = Product.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

  def create
    @product = Product.new product_params
    @product.user = @user

    if @product.save
      render json: "Product created!"
    else
      render json: @product.errors.full_messages
    end
  end

  private

  def product_params
    params.require(:product).permit([ :title,
                                      :description,
                                      :price,
                                      :sale_price,
                                      :category_id,
                                      { tag_ids: [] }
                                    ])
  end
end
