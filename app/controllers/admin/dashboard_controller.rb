class Admin::DashboardController < ApplicationController

  def index
    @users = User.order(:id)
    @product_count = Product.count
    @review_count = Review.count
  end
end
