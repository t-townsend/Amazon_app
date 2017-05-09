class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find params[:product_id]
    vote = Vote.new is_up:params[:is_up], user: current_user, product: product
    if vote.save
      redirect_to product, notice: "You voted up"
    else
      redirect_to product, alert: vote.errors.full_messages.join(', ')
    end
  end

  def update
  end

  def destroy
  end
end
