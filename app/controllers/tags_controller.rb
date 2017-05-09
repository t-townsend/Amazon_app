class TagsController < ApplicationController

  def index
    @product = Product.find(params[:id])
    @tags = Tag.all
  end

  def show
    @product = Product.find(params[:id])
    @tag = Tag.find(params[:product_id])
  end
end
