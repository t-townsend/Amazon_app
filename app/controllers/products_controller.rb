class ProductsController < ApplicationController
before_action :find_product, only: [:show, :edit, :updat, :destroy]
before_action :authenticate_user!, except: [:index, :show]

  def new
    @product = Product.new
    @review = Review.new
  end

  def create
  @product = Product.new(params.require(:product).permit(:title, :description, :price, :category_id))
  @product.user = current_user
  if @product.save
    redirect_to product_path(@product)
  else
    render :new
  end

  end

  def index
    @products = Product.last(20)
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
  @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    product_params = params.require(:product).permit([:title, :description, :price, :category_id])


    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end

  end

  def find_product
    @product = Product.find params[:id]
  end


  def destroy
    product = Product.find params[:id]
    product.destroy
    redirect_to products_path
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
  end

end
