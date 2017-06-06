class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @products = user.favourited_products

    render 'favourites/index'
  end

  def create
    product = Product.find(params[:product_id])

    if cannot? :favourite, product
      redirect_to(
        product_path(product),
        alert: 'Favouriting your own product is not allowed'
      )
      return
    end

    favourite = Favourite.new(user: current_user, product: product)

    if favourite.save
      redirect_to product_path(product), notice: 'Product favourited!'
    else
      redirect_to(
        product_path(product),
        alert: favourite.errors.full_messages.join(', ')
      )
    end
  end

  def destroy
    favourite = Favourite.find(params[:id])
    product = favourite.product

    if cannot? :favourite, product
      redirect_to(
        product_path(product),
        alert: 'Unfavouriting your own product is not allowed'
      )
      return
    end

    if favourite.destroy
      redirect_to product_path(product), notice: 'Product unfavourited'
    else
      redirect_to product_path(product),
        alert: favourite.errors.full_messages.join(', ')
    end
  end
end
