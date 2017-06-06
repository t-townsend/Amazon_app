class Api::V1::SessionsController < Api::BaseController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      render json: "Signed In!"
    else
      render json: "Could not sign in!"
    end
  end

  def destroy
    session[:user_id] = nil
    render json: "Signed Out!"
  end
end
