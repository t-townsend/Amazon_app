class Admin::DashboardController < ApplicationController
  before_filter :authorize_admin, only: :index

  def index
    @products = Product.all
    @users = User.all
    @reviews = Review.all
  end

  def authorize_admin
    redirect_to root_path, alert: 'Access denied' unless current_user.is_admin
  end
end
