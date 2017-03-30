class ContactController < ApplicationController
  def index
  end

  def create
    @name = params[:name]
    # render plain: "Thank you for contacting us, #{@name}!"
    redirect_to contact_path({ name: params[:name] })
  end
end
