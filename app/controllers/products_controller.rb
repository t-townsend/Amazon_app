class ProductsController < ApplicationController
  def new
    @product = Product.new
    @review = Review.new
  end

  def create
  @product = Product.new(params.require(:product).permit(:title, :description, :price, :category_id))

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
