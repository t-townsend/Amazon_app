class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_action :authenticate_user

  private

  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    head :unauthorized if @user.nil?
  end

end
